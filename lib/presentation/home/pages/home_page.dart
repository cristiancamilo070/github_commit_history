import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/animations/animations.dart';
import 'package:github_commit_history/core/widgets/buttons/floating-button.dart';
import 'package:github_commit_history/core/widgets/drawer/drawer.dart';
import 'package:github_commit_history/core/widgets/drawer/navbar.dart';
import 'package:github_commit_history/domain/models/commits_model.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commit_tree_use_case.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commits_use_case.dart';
import 'package:github_commit_history/presentation/home/controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  final homeAnimationsController = Get.put(HomeAnimationsController());

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    startHomeAnimations();
    return AdvancedDrawer(
      backdropColor: AppTheme.colors.appTertiary,
      controller: controller.advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      openRatio: 0.66,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.r)),
      ),
      drawer: const HomeDrawer(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.colors.white,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  AppTheme.colors.white,
                  AppTheme.colors.white.withOpacity(0.3),
                  AppTheme.colors.appSecondary.withOpacity(0.2),
                  AppTheme.colors.white.withOpacity(0.3),
                  AppTheme.colors.white,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    HomeNavbar(),
                    Expanded(
                      child: Text(
                        'GITHUB_COMMIT_HISTORY'.tr,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppTheme.colors.appSecondary,
                          fontSize: AppTheme.fontSize.f18,
                          fontWeight: FontWeight.bold,
                        ),
                      ).paddingSymmetric(horizontal: 16.w),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.getCommits(
                          GetCommitsParams(
                            controller.ownerTitle.value,
                            controller.repoTitle.value,
                          ),
                        );
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
                                  color: AppTheme.colors.appPrimary
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              FontAwesomeIcons.rotateRight,
                              color: AppTheme.colors.white,
                              size: 22.2.r,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                header(),
                body(),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 15.w, bottom: 25.w),
          child: HomeFloatingButton(
            onTap: () async {
              await controller.showBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Obx(
      () {
        return Column(
          children: [
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.github,
                  color: AppTheme.colors.appSecondary,
                  size: 40.r,
                ).paddingOnly(left: 24.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'By: ',
                          style: AppTheme.style.regular.copyWith(
                            color: AppTheme.colors.appSecondary,
                            fontSize: AppTheme.fontSize.f14,
                          ),
                          children: [
                            TextSpan(
                              text: controller.ownerTitle.value,
                              style: AppTheme.style.bold.copyWith(
                                color: AppTheme.colors.appSecondary,
                                fontSize: AppTheme.fontSize.f14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Repository: ',
                          style: AppTheme.style.regular.copyWith(
                            color: AppTheme.colors.appSecondary,
                            fontSize: AppTheme.fontSize.f14,
                          ),
                          children: [
                            TextSpan(
                              text: controller.repoTitle.value,
                              style: AppTheme.style.bold.copyWith(
                                color: AppTheme.colors.appSecondary,
                                fontSize: AppTheme.fontSize.f14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                ),
              ],
            ),
            heightSpace16,
          ],
        );
      },
    );
  }

  Widget body() {
    return Obx(
      () {
        return (!controller.commitLoading.value)
            ? Column(
                children: [
                  Text('SELECT_COMMIT_TO'.tr,
                      style: AppTheme.style.bold.copyWith(
                        fontSize: AppTheme.fontSize.f16,
                        color: AppTheme.colors.appSuccess,
                      )).paddingSymmetric(horizontal: 16.w),
                  heightSpace16,
                  SizedBox(
                    height: 390.h,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => heightSpace16,
                      itemCount: controller.listOfCommits.value?.length ?? 0,
                      itemBuilder: (context, index) {
                        GitHubCommitModel commit =
                            controller.listOfCommits.value![index];

                        return buildCommitItem(commit);
                      },
                    ).paddingSymmetric(horizontal: 16.w),
                  )
                ],
              )
            : (controller.commitError.value)
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.circleExclamation,
                            color: AppTheme.colors.appAlert,
                          ),
                          heightSpace8,
                          Text(
                            'ERROR_SERVER'.tr,
                            textAlign: TextAlign.center,
                            style: AppTheme.style.bold.copyWith(
                              fontSize: AppTheme.fontSize.f14,
                              color: AppTheme.colors.appAlert,
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 50.w),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.colors.appSecondary,
                        backgroundColor: AppTheme.colors.appQuaternary,
                        strokeWidth: 5,
                      ),
                    ),
                  );
      },
    );
  }

  Widget buildCommitItem(GitHubCommitModel commitModel) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              await controller.getTreeCommit(
                  title: commitModel.commit.message,
                  params: GetCommitTreeParams(commitModel.commit.tree.url));
            },
            backgroundColor: AppTheme.colors.appSecondary,
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.eye,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async {
          await controller.getTreeCommit(
              title: commitModel.commit.message,
              params: GetCommitTreeParams(commitModel.commit.tree.url));
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppTheme.colors.appPrimary.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            title: Text(commitModel.commit.message,
                style: AppTheme.style.bold.copyWith(
                  fontSize: AppTheme.fontSize.f16,
                  color: AppTheme.colors.appPrimary,
                )).paddingOnly(top: 4.h),
            leading: FaIcon(
              FontAwesomeIcons.upLong,
              color: AppTheme.colors.appSuccess,
              size: 30.r,
            ).paddingOnly(left: 14.w),
            contentPadding: EdgeInsets.only(right: 8.w),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace4,
                Text.rich(
                  TextSpan(
                    text: 'By: ',
                    style: AppTheme.style.bold.copyWith(
                      color: AppTheme.colors.appSecondary,
                    ),
                    children: [
                      TextSpan(
                        text: commitModel.commit.author.name,
                        style: AppTheme.style.regular.copyWith(
                          color: AppTheme.colors.appSecondary,
                        ),
                      ),
                      TextSpan(
                        text: ' - ',
                        style: AppTheme.style.bold.copyWith(
                          color: AppTheme.colors.appTertiary,
                        ),
                      ),
                      TextSpan(
                        text: commitModel.commit.author.email,
                        style: AppTheme.style.regular.copyWith(
                          color: AppTheme.colors.appTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace2,
              ],
            ),
            tileColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
