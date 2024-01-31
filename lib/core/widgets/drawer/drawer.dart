import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/controllers/main_controller.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/drawer/items/items.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25.h, bottom: 25.h, left: 25.w),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.colors.appPrimary.withOpacity(0.9),
                        AppTheme.colors.appSecondary.withOpacity(0.7),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/github-mark-white.svg',
                    height: 120,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Text(
                        'WELCOME'.tr,
                        style: AppTheme.style.bold.copyWith(
                          fontSize: AppTheme.fontSize.f22,
                          color: AppTheme.colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              heightSpace16,
              const DrawerItems(),
            ],
          ),
        ],
      ));
    });
  }
}
