part of '../presentation.dart';

class UiCheckbox extends StatefulWidget {
  const UiCheckbox(
      {super.key,
      required this.onChange,
      required this.theme,
      this.isChecked,
      this.enabled = true,
      this.checkedIcon = AppIcons.checkboxCheckedIcon,
      required this.label});

  final Function(bool) onChange;
  final BaseTheme theme;
  final bool? isChecked;
  final bool enabled;
  final String label;
  final String checkedIcon;

  @override
  State createState() => _UiCheckboxState();
}


class _UiCheckboxState extends State<UiCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.enabled) {
              setState(() {
                _isSelected = !_isSelected;
                widget.onChange(_isSelected);
              });
            }
          },
          child: AnimatedContainer(
            margin:  const EdgeInsets.only(right: AppValues.padding8),
            duration: const Duration(milliseconds: AppValues.animationDurationMills),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppValues.radius4),
              border: _isSelected
                  ? null
                  : Border.all(
                      color: widget.theme.getWhiteTextColor(),
                      width: 1,
                    ),
            ),
            width: AppValues.iconSize20,
            height: AppValues.iconSize20,
            child: _isSelected
                ? SvgPicture.asset(
              widget.checkedIcon,
              width: AppValues.iconSize20,
              height: AppValues.iconSize20,
            )
                : null,
          ),
        ),
        Expanded(
            child: Text(
          widget.label,
          style: context.textTheme.bodyMedium?.copyWith(
            color: Colors.white
          ),
        )),
      ],
    );
  }
}
