import 'package:flutter/material.dart';

class GhostButton extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final Color? splashColor;
  final Color highlightColor;
  final void Function()? onTap;

  const GhostButton({
    super.key,
    required this.textStyle,
    required this.title,
    this.highlightColor = Colors.transparent,
    this.splashColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onTap,
        splashColor: splashColor,
        highlightColor: highlightColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: textStyle),
        ),
      ),
    );
  }
}
