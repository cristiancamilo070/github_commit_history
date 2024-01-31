// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/animations/animations.dart';

class HomeFloatingButton extends StatelessWidget {
  final Function() onTap;
  const HomeFloatingButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAnimationsController>(
      builder: (_) {
        return Tooltip(
          message: 'SEARCH_COMMIT_HISTORY'.tr,
          child: Container(
            width: 60.r,
            height: 60.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.colors.appTertiary.withOpacity(0.9),
                  AppTheme.colors.appPrimary,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.colors.appPrimary.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 35.r,
                color: AppTheme.colors.white,
              ),
              onPressed: onTap,
            ),
          ),
        );
      },
    );
  }
}
