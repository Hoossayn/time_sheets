import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_sheets/app/core/constant/app_values.dart';

import '../../../../../flavours/flavour_config.dart';
import '../../../../blocs/timer/timer_bloc.dart';
import '../../../../data/models/timer.dart';
import '../../../../utils/utils.dart';


class CounterWidget extends StatelessWidget {
  final TimerModel timerModel;
  final bool compact;
  final theme = FlavourConfig.instance.config.theme;
  CounterWidget({super.key, required this.timerModel, this.compact = true});

  @override
  Widget build(BuildContext context) {
    return compact ? _buildCompact(context) : _buildFull(context);
  }

  Widget _buildCompact(BuildContext context) {
    return BlocBuilder<TimerModel, TimerState>(
      builder: (context, state) {
        final duration = Duration(
            seconds: state.tDuration);
        final color = state is TimerRunInProgress ? Colors.black : Colors.white;

        return Container(
          padding: const EdgeInsets.all(16).copyWith(top: 6, bottom: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(64),
            color: state is TimerRunInProgress
                ? Colors.white
                : Colors.white.withOpacity(0.16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Utils.formatDuration(duration),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(height: 20 / 14, fontSize: 14, color: color),
              ),
              const SizedBox(
                width: 4,
              ),
              if (state is! TimerRunComplete)
                InkWell(
                  onTap: () {
                    timerModel.toggleTimer();
                  },
                  child: Icon(
                    state is TimerRunInProgress
                        ? CupertinoIcons.pause
                        : CupertinoIcons.play_fill,
                    color: color,
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Widget _buildFull(BuildContext context) {
    return BlocBuilder<TimerModel, TimerState>(
      builder: (context, state) {
        final duration = Duration(
            seconds: state.tDuration);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Utils.formatDuration(duration),
              style: theme.bodySmallTextStyle
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 36),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFullIcon(context,
                    CupertinoIcons.stop_fill,
                    color: theme.getWhiteTextColor(),
                    onTap: () {
                  timerModel.stopTimer();
                }),
                const SizedBox(
                  width: 16,
                ),
                _buildFullIcon(
                  context,
                  state is TimerRunInProgress
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play_fill,
                  onTap: () {
                    timerModel.toggleTimer();
                  },
                  backgroundColor:
                      state is TimerRunInProgress ? Colors.white : Colors.white.withOpacity(0.16),
                  color: state is TimerRunInProgress ? Colors.black : Colors.white,
                )
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildFullIcon(BuildContext context, IconData icon,
      {Color? backgroundColor, VoidCallback? onTap, Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppValues.width48,
        height: AppValues.height48,
        decoration: BoxDecoration(
          color:
              backgroundColor ?? Colors.white.withOpacity(0.16),
          borderRadius: BorderRadius.circular(64),
        ),
        child: Icon(
          icon,
          size: AppValues.iconSize32,
          color: color,
        ),
      ),
    );
  }
}
