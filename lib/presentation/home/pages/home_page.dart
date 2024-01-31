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
import 'package:github_commit_history/core/widgets/forms/github_repo_form.dart';
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
                HomeNavbar(),
                body(),
              ],
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 15.w, bottom: 25.w),
          child: HomeFloatingButton(
            onTap: () async {
              await _showBottomSheet();
            },
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Obx(
      () => Column(
        children: [
          Text(
            'GITHUB_COMMIT_HISTORY'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.colors.appPrimary,
              fontSize: AppTheme.fontSize.f36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget body() {
    return Obx(
      () {
        return (controller.listOfCommits.value != null)
            ? Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => heightSpace16,
                    itemCount: controller.listOfCommits.value?.length ?? 0,
                    itemBuilder: (context, index) {
                      GitHubCommitModel commit =
                          controller.listOfCommits.value![index];

                      return buildCommitItem(commit);
                    },
                  ).paddingSymmetric(horizontal: 16.w),
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

  Future<void> _showBottomSheet([void Function()? cb]) async {
    await Get.bottomSheet(
      _searchCommitsSheet(),
      elevation: 34,
      isScrollControlled: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );

    cb?.call();
  }

  Widget _searchCommitsSheet() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 270.h,
        child: GitHubRepoForm(
          searchButton: () async {
            controller.getCommits(GetCommitsParams(
              controller.ownerController.text,
              controller.repoController.text,
            ));
          },
        ),
      ),
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
            trailing: FaIcon(FontAwesomeIcons.github),
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
                Text(
                  commitModel.commit.message,
                  style: TextStyle(
                    color: AppTheme.colors.appSecondary,
                  ),
                ),
              ],
            ),
            tileColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
