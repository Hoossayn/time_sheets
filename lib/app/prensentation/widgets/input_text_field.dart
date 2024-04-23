part of '../presentation.dart';

class InputTextField extends StatelessWidget {
  static const int defaultMinimumLines = 1;

  static const int defaultMaximumLines = 3;

  static const double defaultVerticalPadding = 0.0;

  const InputTextField({
    super.key,
    required this.theme,
    required this.onInputChanged,
    this.hint,
    this.height = AppValues.height40,
    this.verticalPadding = defaultVerticalPadding,
    this.minLines = defaultMinimumLines,
    this.maxLines = defaultMaximumLines,
    this.error,
    this.isActive,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  final BaseTheme theme;
  final String? hint;
  final TextEditingController? controller;

  final String? error;
  final bool? isActive;
  final Function onInputChanged;
  final double? height;
  final double verticalPadding;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 56,
          child: TextField(
            inputFormatters: inputFormatters ??
                InputValidationBuilder()
                    .limitCharLengthTo(
                        length: TextInputFilters.genericTextLengthLarge)
                    .limitToExtendedAlphanumericCharacters()
                    .build(),
            keyboardType: keyboardType,
            controller: controller,
            enabled: isActive,
            minLines: minLines,
            maxLines: maxLines,
            onChanged: (string) {
              onInputChanged(string);
            },
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.white
            ),
            decoration: InputDecoration(
              filled: (isActive != null) ? !isActive! : null,
              fillColor:
                  (isActive ?? true) ? null : theme.getLightGreyBGColor(),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: AppValues.padding16, vertical: verticalPadding),
              hintStyle: context.textTheme.bodyLarge?.copyWith(
                color: theme.getWhiteTextColor(),
              ),

              hintText: hint,
              border: error == null
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.16),
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.getErrorColor(),
                      ),
                    ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white.withOpacity(0.16),
                ),
              ),
              focusedBorder: error == null
                  ? OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.16),
                      ),
                    )
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                        color: theme.getErrorColor(),
                      ),
                    ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: AppValues.padding2),
            child: Text(
              error!,
              textAlign: TextAlign.left,
              style: theme.errorTextStyle,
            ),
          ),
      ],
    );
  }
}
