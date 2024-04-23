import 'package:flutter/services.dart';
import 'package:time_sheets/app/utils/text_input_filters.dart';

class InputValidationBuilder {
  InputValidationBuilder();

  final List<TextInputFormatter> _formatters = [];

  List<TextInputFormatter> build() => _formatters;

  InputValidationBuilder limitCharLengthTo({required int length}) {
    _formatters.add(TextInputFilters.limitToLength(length));
    return this;
  }

  InputValidationBuilder limitToWhitelistedCharacters() {
    _formatters.add(TextInputFilters.limitToWhitelistedCharacters());
    return this;
  }

  InputValidationBuilder limitToDigitsOnly() {
    _formatters.add(TextInputFilters.limitToNumericOnly());
    return this;
  }

  InputValidationBuilder limitToTextOnly() {
    _formatters.add(TextInputFilters.limitToTextOnly());
    return this;
  }

  InputValidationBuilder limitToAlphanumericCharacters() {
    _formatters.add(TextInputFilters.limitToAlphaNumericCharactersOnly());
    return this;
  }

  InputValidationBuilder limitToExtendedAlphanumericCharacters() {
    _formatters
        .add(TextInputFilters.limitToExtendedAlphaNumericCharactersOnly());
    return this;
  }

  InputValidationBuilder limitToDecimalDigitsOnly() {
    _formatters.add(TextInputFilters.limitToDecimalDigits());
    return this;
  }
}
