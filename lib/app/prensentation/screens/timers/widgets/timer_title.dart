import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../flavours/flavour_config.dart';
import '../../../../data/models/timer.dart';

class TimerTitle extends StatelessWidget {
   TimerTitle({
    super.key,
    required this.context,
    required this.timer,
  });

  final BuildContext context;
  final TimerModel timer;
  final theme = FlavourConfig.instance.config.theme;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 4,
      children: [
        Text(
          DateFormat("EEEE").format(timer.startTime),
          style: theme.bodySmallTextStyle.copyWith(
            color: theme.getWhiteTextColor(),
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          DateFormat("dd.MM.yyyy").format(timer.startTime),
          style: theme.titleMedium
        ),
        RichText(
          text: TextSpan(
            text: "Start Time ",
            children: [
              TextSpan(
                  text: DateFormat(DateFormat.HOUR24_MINUTE)
                      .format(timer.startTime)),
            ],
            style: theme
                .bodySmallTextStyle
                .copyWith(fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
