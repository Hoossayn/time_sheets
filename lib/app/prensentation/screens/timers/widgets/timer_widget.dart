import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:time_sheets/app/core/constant/app_values.dart';
import 'package:time_sheets/app/prensentation/presentation.dart';

import '../../../../core/routes/routes.dart';
import '../../../../data/models/project.dart';
import '../../../../data/models/task.dart';
import '../../../../data/models/timer.dart';
import '../../../../utils/utils.dart';
import 'counter_widget.dart';

class TimerWidget extends StatelessWidget {
  final TimerModel timerModel;
  final Project project;
  final Task task;
  const TimerWidget(
      {super.key,
      required this.timerModel,
      required this.project,
      required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: timerModel,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: buildSummary(context, project, task, timerModel)),
            CounterWidget(
              timerModel: timerModel,
            )
          ],
        ),
      ),
    );
  }

  Widget buildProjectBanner(BuildContext context, Project project) {
    return Container(
      width: 2,
      constraints: const BoxConstraints(
        minHeight: 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: project.color,
      ),
    );
  }

  Widget buildSummary(
      BuildContext context, Project project, Task task, TimerModel timerModel) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: project.color,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          //borderRadius: const BorderRadius.all(Radius.circular(1))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.pushNamed(Routes.timerDetailScreen.toNamed, extra: task);

          },
            child: buildSummaryTile(
              context,
              timerModel.favorite
                  ? CupertinoIcons.star_fill
                  : CupertinoIcons.star,
              task.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.15,
                  height: 24 / 16),
            ),
          ),
          verticalSpace(AppValues.space4),
          buildSummaryTile(context, CupertinoIcons.briefcase, project.name),
          verticalSpace(AppValues.space4),
          buildSummaryTile(context, CupertinoIcons.time,
              "Deadline ${Utils.format(task.deadline)}"),
        ],
      ),
    );
  }

  Widget buildSummaryTile(BuildContext context, IconData icon, String title,
      {TextStyle? style}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.white,
        ),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          child: Text(
            title,
            style: style ??
                Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(letterSpacing: 0.25, color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
