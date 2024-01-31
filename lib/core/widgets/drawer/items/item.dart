import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';

class HomeDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool? padding;
  final Function() onTap;
  const HomeDrawerItem({
    super.key,
    required this.title,
    this.padding,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double leftPadding = 10.w;
    if (padding ?? true) {
      leftPadding = 40;
    }
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.white.withOpacity(0.3),
      child: Container(
          padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: leftPadding),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppTheme.colors.white,
                size: 17.5.r,
              ),
              widthSpace10,
              Text(
                title,
                style: AppTheme.style.bold.copyWith(
                  color: AppTheme.colors.white,
                ),
              ),
            ],
          )),
    );
  }
}
