part of app_inputs;

enum AppInputType {
  ///
  alphabet,

  /// Represents a text input type.
  text,

  /// Represents a number input type.
  number,

  /// Represents a phone input type.
  phone,

  /// Represents an email input type.
  email,

  /// Represents a password input type.
  password,

  //
  dropdownMenu,
}

class UtilsInput {
  static List<TextInputFormatter>? inputFormatters(
    AppInputType type,
    List<TextInputFormatter>? formatter,
  ) {
    late final List<TextInputFormatter> inputFormatter;
    switch (type) {
      case AppInputType.alphabet:
        final alphabetRegex = RegExp(r"^[a-zA-Z\s]+$");
        inputFormatter = [FilteringTextInputFormatter.allow(alphabetRegex)];
        break;
      case AppInputType.number:
      case AppInputType.phone:
        inputFormatter = [FilteringTextInputFormatter.digitsOnly];
        break;
      default:
        inputFormatter = [FilteringTextInputFormatter.singleLineFormatter];
        break;
    }

    return [...?formatter, ...inputFormatter];
  }

  static TextInputType keyboardType(AppInputType type) {
    switch (type) {
      case AppInputType.number:
        return TextInputType.number;
      case AppInputType.phone:
        return TextInputType.phone;
      case AppInputType.email:
        return TextInputType.emailAddress;
      case AppInputType.password:
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
    }
  }
}
