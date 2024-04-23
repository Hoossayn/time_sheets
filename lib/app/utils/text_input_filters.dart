import 'package:flutter/services.dart';

class TextInputFilters {
  static final Pattern _patternDigitsOnly = RegExp(r'[0-9]');
  static final Pattern _patternTextOnly = RegExp(r'^\d+(?:\.\d+)?$');
  static final Pattern _patternAlphaNumericChars = RegExp(r"[a-zA-Z0-9 \-,'.]");
  static final Pattern _patternPhoneNumber =
      RegExp(r'((?:[+0]9)?[0-9]{10,12}$)');
  static final Pattern _patternDecimalDigit = RegExp(r'^\d+\.?\d{0,2}');
  static const rawPhoneNumberMaxLength = 10;
  static const emailMaxLength = 255;
  static const genericCodeMaxLength = 255;
  static const genericTextLengthLarge = 255;
  static final Pattern _patternExtendedAlphanumericChars =
      RegExp(r"[a-zA-Z0-9 \-,'.ñÑ]");

  static FilteringTextInputFormatter limitToWhitelistedCharacters() {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'));
  }

  static LengthLimitingTextInputFormatter limitToLength(int length) {
    return LengthLimitingTextInputFormatter(length);
  }

  static FilteringTextInputFormatter limitToNumericOnly() {
    return FilteringTextInputFormatter.allow(_patternDigitsOnly);
  }

  static FilteringTextInputFormatter limitToTextOnly() {
    return FilteringTextInputFormatter.allow(_patternTextOnly);
  }

  static FilteringTextInputFormatter limitToAlphaNumericCharactersOnly() {
    return FilteringTextInputFormatter.allow(_patternAlphaNumericChars);
  }

  static FilteringTextInputFormatter
      limitToExtendedAlphaNumericCharactersOnly() {
    return FilteringTextInputFormatter.allow(_patternExtendedAlphanumericChars);
  }

  static FilteringTextInputFormatter limitToPhoneNumberPattern() {
    return FilteringTextInputFormatter.allow(_patternPhoneNumber);
  }

  static FilteringTextInputFormatter limitToDecimalDigits() {
    return FilteringTextInputFormatter.allow(_patternDecimalDigit);
  }
}
