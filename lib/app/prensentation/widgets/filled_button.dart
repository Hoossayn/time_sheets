part of '../presentation.dart';

class BaseButton extends StatefulWidget {
  final String title;
  final bool isEnabled;
  final Function onPressed;
  final bool animateLoading;
  final bool isLoading;

  final theme = FlavourConfig.instance.config.theme;

  BaseButton({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.animateLoading = false,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  BaseButtonState createState() => BaseButtonState();
}

class BaseButtonState extends State<BaseButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: AppValues.height40,
            child: TextButton(
              onPressed: widget.isEnabled ? () => _onPressed() : null,
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.16)
              ),
              child: Text(
                widget.title,
                style: widget.theme.filledButtonTextStyle,
              )
            ),
          ),
        ),
      ],
    );
  }

  void _onPressed() {
    widget.onPressed();
  }
}
