import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/prensentation/screens/timers/widgets/timer_widget.dart';

import '../../../../flavours/flavour_config.dart';
import '../../../blocs/timesheet/time_sheets_bloc.dart';
import '../../../blocs/timesheet/time_sheets_state.dart';
import '../../../data/models/timer.dart';
import '../../presentation.dart';
import '../../widgets/prominent_icon.dart';

abstract class BaseTimeSheetWidget extends StatefulWidget {
  String get emptyTextTitle;

  String get emptyTextDescription;

  String get emptyTextAction => "Get Started";

  Widget get emptyIcon => const Icon(
        CupertinoIcons.star_fill,
        size: 96,
        color: Colors.white,
      );

  TimerType get timerType => TimerType.local;

  bool get isFavoritesSheet => false;

  final theme = FlavourConfig.instance.config.theme;

   BaseTimeSheetWidget({super.key});

  @override
  State< BaseTimeSheetWidget> createState() => _BaseTimeSheetWidgetState();
}

class _BaseTimeSheetWidgetState extends State<BaseTimeSheetWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TimesheetBloc, TimerSheetState>(
      builder: (context, state) {
        switch (state.status) {
          case TimerSheetStatus.loading:
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          case TimerSheetStatus.error:
            return buildErrorWidget(context, () {
              context
                  .read<TimesheetBloc>()
                  .add(TimerSheetEventLoad(refresh: true));
            });
          default:
            return buildListWidget(context, state.timers, () {
              context
                  .read<TimesheetBloc>()
                  .add(TimerSheetEventLoad(refresh: true));
              return Future.value();
            });
        }
      },
    );
  }

  Widget buildListWidget(BuildContext context, List<TimerModel> timers,
      Future<void> Function() onRefresh) {
    final items = timers.where((element) {
      if (widget.isFavoritesSheet) {
        return element.favorite;
      }
      return element.timerType == widget.timerType;
    }).toList();
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: items.isEmpty ? buildEmptyWidget(context) : buildList(items),
    );
  }

  Widget buildEmptyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProminentIcon(prominentIcon: widget.emptyIcon),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  widget.emptyTextTitle,
                  textAlign: TextAlign.center,
                  style: widget.theme.bodySmallBoldTextStyle.copyWith(
                    fontSize: 28,
                        fontWeight: FontWeight.w700,
                    color: Colors.white
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.emptyTextDescription,
                  textAlign: TextAlign.center,
                  style: widget.theme.bodyLargeTextStyle.copyWith(
                    color: widget.theme.getWhiteTextColor(),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      height: 24 / 16),
                ),
                const SizedBox(
                  height: 9,
                ),
              ],
            ),
            ),


            SizedBox.fromSize(
              size: const Size.fromHeight(48),
              child: BaseButton(
                title: widget.emptyTextAction,
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildList(List<TimerModel> timers) {
    return ListView.builder(
      itemCount: timers.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return buildTimer(timers[index]);
      },
    );
  }

  Widget buildTimer(TimerModel timer) {
    final project = context.read<TimesheetBloc>().getTimerProject(timer);
    final task = context.read<TimesheetBloc>().getTimerTask(timer);
    return TimerWidget(project: project, task: task, timerModel: timer);
  }

  Widget buildErrorWidget(BuildContext context, VoidCallback onRetry) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ProminentIcon(
                prominentIcon: Icon(
              Icons.warning,
              size: 96,
            )),
            const SizedBox(
              height: 32,
            ),
            Text(
              "There seems to be an error",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Oops an error encountered while getting your favourite timers",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
