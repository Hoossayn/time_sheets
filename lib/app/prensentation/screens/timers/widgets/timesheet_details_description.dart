part of '../../../presentation.dart';

class TimeSheetDetailsDescription extends StatelessWidget {
   const TimeSheetDetailsDescription({
    super.key,
    required this.description,
    this.showIcon
  });

  final String description;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Description', style: context.textTheme.bodySmall?.copyWith(
                color: Colors.white
            ),
            ),
            Visibility(
              visible: showIcon ?? false,
                child: const Icon(CupertinoIcons.pen, color: Colors.white,
                ))
          ],
        ),
        verticalSpace(AppValues.space8),
        Text(description,
          style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white
          ),
        )
      ],
    );
  }
}
