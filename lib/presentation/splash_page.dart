import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/controllers/main_controller.dart';
import 'package:github_commit_history/core/routes/app_routes.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final MainController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SafeArea(
          bottom: true,
          child: Obx(() {
            final isReady = _controller.isReadyDependencies.value;

            if (isReady) {
              Future.delayed(const Duration(seconds: 2), () {
                Get.offAllNamed(RoutesPaths.homePage);
              });
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ZoomIn(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
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
                        Text(
                          'Github ',
                          style: AppTheme.style.bold.copyWith(
                            color: AppTheme.colors.appPrimary,
                            fontSize: AppTheme.fontSize.f22,
                          ),
                        ),
                        Text(
                          'Commit History ',
                          style: AppTheme.style.bold.copyWith(
                            color: AppTheme.colors.appTertiary,
                            fontSize: AppTheme.fontSize.f14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  _controller.versionApp,
                  style: AppTheme.style.regular.copyWith(
                    color: AppTheme.colors.appSecondary,
                    fontSize: AppTheme.fontSize.f12,
                  ),
                ),
                Text(
                  'By: Cristian Cruz',
                  style: AppTheme.style.regular.copyWith(
                    color: AppTheme.colors.appTertiary,
                    fontSize: AppTheme.fontSize.f12,
                  ),
                ).paddingOnly(
                  bottom: 40.w,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
