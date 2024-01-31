part of app_inputs;

class InputValidations {
  static String? validate(String? data, AppInputParameters builder) {
    final value = data ?? '';
    if (value.isEmpty) {
      if (!builder.isRequired) {
        return null;
      }

      return "This field is required";
    }

    return null;
  }

  static String? password(String password) {
    // Check if it has at least 6 characters
    RegExp regExp1 = RegExp(r'^.{6,}$');
    if (!regExp1.hasMatch(password)) {
      return 'The password must be at least 6 characters.';
    }

    return null;
  }

  static numberPhone(String phone) {
    return RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phone);
  }

  static emailAddress(String email) {
    return RegExp(
      r'[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}',
    ).hasMatch(email);
  }
}
