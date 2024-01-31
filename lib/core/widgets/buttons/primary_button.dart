import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import Flutter SVG package
import 'package:github_commit_history/core/themes/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final Color? overlayColor;
  final double? borderRadius;
  final Color? color;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final TextStyle? style;
  final String? text;
  final bool isDisabled;
  final String? svgAsset;

  const PrimaryButton({
    Key? key,
    this.color,
    required this.onPressed,
    this.height = 50,
    this.style,
    this.text = '',
    this.width,
    this.borderRadius = 5,
    this.overlayColor,
    this.isDisabled = false,
    this.svgAsset,
  }) : super(key: key);

  Color get _color => color ?? AppTheme.colors.appPrimary;

  TextStyle get _defaultStyle =>
      style ??
      AppTheme.style.bold.copyWith(
        fontSize: AppTheme.fontSize.f16,
        color: AppTheme.colors.white,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            isDisabled ? AppTheme.colors.appGrey : _color,
          ),
          overlayColor: MaterialStateProperty.all(overlayColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            ),
          ),
        ),
        onPressed: isDisabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgAsset != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SvgPicture.asset(
                  svgAsset!,
                  height: 20,
                ),
              ),
            AutoSizeText(
              text.toString(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: _defaultStyle,
            ),
          ],
        ),
      ),
    );
  }
}
