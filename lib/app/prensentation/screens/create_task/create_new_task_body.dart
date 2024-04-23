import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/core/constant/app_values.dart';
import 'package:time_sheets/app/core/core.dart';
import 'package:time_sheets/app/data/models/project.dart';
import 'package:time_sheets/app/prensentation/presentation.dart';

import '../../../../flavours/flavour_config.dart';
import '../../../blocs/timesheet/time_sheets_bloc.dart';
import '../../../data/models/form.dart';
import '../../../data/models/task.dart';
import '../../widgets/checkbox.dart';
import '../../widgets/dropdown.dart';
import 'cubit/time_form_cubit.dart';

class CreateNewTaskBody extends StatelessWidget {
   CreateNewTaskBody({super.key});

  final theme = FlavourConfig.instance.config.theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 48),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomDropDownMenu<Project>(
              label: context.localised.project,
              value: context.watch<TimeFormCubit>().form.projectId,
              items: context.read<TimesheetBloc>().state.projects,
              itemBuilder: (Project project) {
                return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: project.color,
                      radius: 6,
                    ),
                    horizontalSpace(AppValues.space6),
                    Text(
                      project.name,
                      style: theme.bodyLargeTextStyle.copyWith(
                        color: theme.getWhiteTextColor()
                      ),
                    ),
                  ],
                );
              },
              onSelected: (Project? project) {
                context.read<TimeFormCubit>()
                    .onProjectChanged(CustomFormField<Project>(value: project));
              },
              selectedItemBuilder: (Project? project) {
                return Text(project?.name ?? context.localised.project, style: theme.bodyLargeTextStyle.copyWith(color: theme.getWhiteTextColor()),);
              },
            ),
            CustomDropDownMenu<Task>(
              label: context.localised.task,
              value: context.watch<TimeFormCubit>().form.taskId,
              items: context.read<TimesheetBloc>().state.tasks,
              itemBuilder: (Task task) {
                return Row(
                  children: [
                    Text(
                      task.name,
                      style: theme.bodyLargeTextStyle.copyWith(
                          color: theme.getWhiteTextColor()
                      ),
                    ),
                  ],
                );
              },
              onSelected: (Task? task) {
                context
                    .read<TimeFormCubit>()
                    .onTaskChanged(CustomFormField<Task>(value: task));
              },
              selectedItemBuilder: (Task? task) {
                return Text(task?.name ?? context.localised.task, style: theme.bodyLargeTextStyle.copyWith(color: theme.getWhiteTextColor()));
              },
            ),
            horizontalSpace(AppValues.space8),
            InputTextField(
              isActive: true,
              hint: context.localised.description,
              theme: theme,
              onInputChanged: (value) {
                context.read<TimeFormCubit>().onDescriptionChanged(
                    CustomFormField<String>(value: value));
              },
            ),
            horizontalSpace(AppValues.space8),
            CustomCheckBox(
              label: context.localised.makeFavourite,
              value: context.read<TimeFormCubit>().form.favorite,
              onCheckedChanged: (value) {
                context
                    .read<TimeFormCubit>()
                    .onFavoriteChanged(CustomFormField<bool>(value: value));
              },
            )
          ],
        ),
      ),
    );
  }
}
