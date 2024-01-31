part of app_inputs;

class AppTextFormField extends StatelessWidget {
  final AppInputParameters inputsParams;

  const AppTextFormField({required this.inputsParams, super.key});

  @override
  Widget build(BuildContext context) {
    final parametersCopy = inputsParams.copyWith(
      validator: inputsParams._validators,
      inputFormatters: inputsParams._formatter(),
      decoration: inputsParams._defaultDecoration(),
    );

    return TextFormField(
      textInputAction: parametersCopy.textInputAction,
      controller: parametersCopy.controller,
      obscureText: parametersCopy.obscureText,
      cursorColor: Colors.black,
      decoration: parametersCopy.decoration,
      inputFormatters: parametersCopy.inputFormatters,
      validator: parametersCopy.validator,
      keyboardType: UtilsInput.keyboardType(parametersCopy.inputType),
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
    );
  }
}
