// ignore_for_file: unnecessary_this

part of app_inputs;

class AppInputParameters {
  final bool obscureText;
  final bool isRequired;
  final Widget suffixIcon;
  final AppInputType inputType;
  final TextInputAction? textInputAction;
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? suffixOnPressed;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final String? errorText;
  final ValueChanged<String>? onSubmitted;
  final bool isError;
  final int? maxLines;

  AppInputParameters({
    Key? key,
    this.obscureText = false,
    this.isRequired = false,
    this.suffixIcon = const SizedBox(),
    this.inputType = AppInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.hintText,
    this.controller,
    this.suffixOnPressed,
    this.validator,
    this.inputFormatters,
    this.decoration,
    this.errorText,
    this.onSubmitted,
    this.isError = true,
    this.maxLines,
  });

  AppInputParameters copyWith({
    bool? obscureText,
    bool? isRequired,
    Widget? suffixIcon,
    AppInputType? inputType,
    TextInputAction? textInputAction,
    String? hintText,
    TextEditingController? controller,
    VoidCallback? suffixOnPressed,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    InputDecoration? decoration,
    String? errorText,
    ValueChanged<String>? onSubmitted,
    bool? isError,
  }) {
    return AppInputParameters(
        obscureText: obscureText ?? this.obscureText,
        isRequired: isRequired ?? this.isRequired,
        suffixIcon: suffixIcon ?? this.suffixIcon,
        inputType: inputType ?? this.inputType,
        textInputAction: textInputAction ?? this.textInputAction,
        hintText: hintText ?? this.hintText,
        controller: controller ?? this.controller,
        suffixOnPressed: suffixOnPressed ?? this.suffixOnPressed,
        validator: validator ?? this.validator,
        inputFormatters: inputFormatters ?? this.inputFormatters,
        decoration: decoration ?? this.decoration,
        errorText: errorText ?? this.errorText,
        onSubmitted: onSubmitted ?? this.onSubmitted,
        isError: isError ?? this.isError,
        maxLines: maxLines ?? this.maxLines);
  }

  ///
  /// @returns: An OutlineInputBorder instance with default settings [OutlineInputBorder].
  OutlineInputBorder _borderDefault() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: AppTheme.colors.appTertiary,
      ),
      borderRadius: BorderRadius.circular(8),
    );
  }

  /// @returns: An OutlineInputBorder instance with default settings [OutlineInputBorder].
  OutlineInputBorder _borderError() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: .5, color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    );
  }

  /// @returns: An OutlineInputBorder instance with default settings [OutlineInputBorder].
  OutlineInputBorder _borderWarning() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: .5, color: Colors.amber),
      borderRadius: BorderRadius.circular(10),
    );
  }

  /// Returns a validator function for form field validation.
  ///
  /// @returns: A validator function [String? Function(String?)].
  String? Function(String?)? get _validators {
    return validator ??
        (String? value) => InputValidations.validate(value ?? "", this);
  }

  /// Returns a list of input formatters based on field parameters.
  ///
  /// @returns: A list of TextInputFormatter instances [List<TextInputFormatter>?].
  List<TextInputFormatter>? _formatter() {
    return UtilsInput.inputFormatters(inputType, inputFormatters);
  }

  /// Returns the default decoration configuration for form fields.
  ///
  /// @param showLabelText: Whether to show the label text or not [bool].
  ///
  /// @returns: An InputDecoration instance with default settings [InputDecoration].
  InputDecoration _defaultDecoration(
      [bool showLabelText = true, String? errorText, bool isError = true]) {
    return InputDecoration(
      labelText: showLabelText ? hintText : null,
      labelStyle: TextStyle(color: AppTheme.colors.appTertiary),
      focusedErrorBorder: _borderDefault(),
      disabledBorder: _borderDefault(),
      errorBorder: isError ? _borderError() : _borderWarning(),
      errorMaxLines: 2,
      errorStyle: TextStyle(
        decorationColor: isError ? Colors.red : Colors.amber,
        color: isError ? Colors.red : Colors.amber,
      ),
      enabledBorder: _borderDefault(),
      focusedBorder: _borderDefault(),
      errorText: errorText,
      suffixIcon: IconButton(
        splashColor: AppTheme.colors.transparent,
        highlightColor: AppTheme.colors.transparent,
        icon: suffixIcon,
        onPressed: suffixOnPressed,
      ),
    );
  }
}
