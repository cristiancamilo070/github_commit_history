import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/animations/animations.dart';
import 'package:github_commit_history/presentation/home/controllers/home_controller.dart';

class HomeNavbar extends StatelessWidget {
  final homeController = Get.put(HomeController());

  HomeNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAnimationsController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _.navbarOpacity1,
              child: ElevatedButton(
                onPressed: () {
                  homeController.advancedDrawerController.showDrawer();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  padding: EdgeInsets.all(12.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.colors.appTertiary.withOpacity(0.9),
                            AppTheme.colors.appPrimary.withOpacity(0.7),
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
                      child: Center(
                        child: ValueListenableBuilder<AdvancedDrawerValue>(
                          valueListenable:
                              homeController.advancedDrawerController,
                          builder: (_, value, __) {
                            return Icon(
                              value.visible
                                  ? FontAwesomeIcons.xmark
                                  : FontAwesomeIcons.bars,
                              color: AppTheme.colors.white,
                              size: 22.2.r,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
