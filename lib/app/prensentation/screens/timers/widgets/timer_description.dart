import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_sheets/app/core/constant/app_values.dart';

import '../../../../data/models/timer.dart';
import '../../../presentation.dart';

class TimerDescription extends StatefulWidget {
  const TimerDescription({
    super.key,
    required this.context,
    required this.timer,
  });

  final BuildContext context;
  final TimerModel timer;

  @override
  State<TimerDescription> createState() => _TimerDescriptionState();
}

class _TimerDescriptionState extends State<TimerDescription> {
  bool expanded = false;
  int? maxLines = 2;

  toggleState() {
    if (expanded) {
      setState(() {
        maxLines = 2;
        expanded = false;
      });
    } else {
      setState(() {
        maxLines = 50;
        expanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(AppValues.space8),
         verticalDivider(color: Colors.white.withOpacity(0.16)),
        verticalSpace(AppValues.space8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Description",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Icon(CupertinoIcons.pencil, color: Colors.white,)
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          widget.timer.description,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
        ),
        const SizedBox(
          height: 4,
        ),
        if (widget.timer.description.length > 50)
          GestureDetector(
              onTap: () {
                toggleState();
              },
              child: Text(expanded ? "Read Less" : "Read More",
                  style: Theme.of(context).textTheme.bodySmall)),
      ],
    );
  }
}
