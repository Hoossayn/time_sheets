
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/core/constant/app_values.dart';
import 'package:time_sheets/app/core/core.dart';
import 'package:time_sheets/app/prensentation/presentation.dart';

import '../../../../flavours/flavour_config.dart';
import '../../../blocs/timesheet/time_sheets_bloc.dart';
import '../../../blocs/timesheet/time_sheets_state.dart';
import 'create_new_task_body.dart';
import 'cubit/time_form_cubit.dart';

class CreateNewTaskScreen extends StatelessWidget {
  CreateNewTaskScreen({super.key});
  final theme = FlavourConfig.instance.config.theme;

  static Route route({required TimesheetBloc timesheetBloc}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: timesheetBloc,
        child: CreateNewTaskScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimeFormCubit(),
      child: BlocListener<TimeFormCubit, TimeFormState>(
        listenWhen: (previous, current) => current is TimerFormSaved,
        listener: (context, state) {
          if (state is! TimerFormSaved) return;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(context.localised.timerCreated),
            ),
          );
          context.read<TimesheetBloc>().add(TimerSheetEventAdd(state.timer));
          Navigator.of(context).pop();
        },
        child: GradientScaffold(
          appBar: _buildAppBar(context, theme),
          body: CreateNewTaskBody(),
          bottomNavigationBar: const SaveButton(),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context, BaseTheme theme) {
  return AppBar(
    title: Text(context.localised.createTimer, style: theme.title1.copyWith( color: theme.getWhiteTextColor())),
    scrolledUnderElevation: 0,
    backgroundColor: theme.getSurfaceVariant(),
    leading: InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(
        CupertinoIcons.chevron_left,
        size: AppValues.iconSize24,
      ),
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: theme.getSurfaceVariant(),
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        height: AppValues.height48,
        padding: const EdgeInsets.symmetric(horizontal: AppValues.padding16),
        child: TextButton(
          onPressed: () {
            context.read<TimeFormCubit>().onSave();
          },
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.16)
          ),
          child: Text(
            context.localised.createTimer,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
