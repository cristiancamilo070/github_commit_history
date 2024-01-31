part of app_inputs;

class AppTextField extends StatelessWidget {
  final AppInputParameters inputsParams;

  const AppTextField({
    required this.inputsParams,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final newParameters = inputsParams.copyWith(
      validator: inputsParams._validators,
      inputFormatters: inputsParams._formatter(),
      decoration: inputsParams._defaultDecoration(
        true,
        inputsParams.errorText,
        inputsParams.isError,
      ),
    );

    return TextField(
      maxLines: newParameters.maxLines,
      textInputAction: newParameters.textInputAction,
      controller: newParameters.controller,
      obscureText: newParameters.obscureText,
      cursorColor: AppTheme.colors.appSecondary,
      decoration: newParameters.decoration,
      inputFormatters: newParameters.inputFormatters,
      keyboardType: UtilsInput.keyboardType(newParameters.inputType),
      onSubmitted: newParameters.onSubmitted,
    );
  }
}
