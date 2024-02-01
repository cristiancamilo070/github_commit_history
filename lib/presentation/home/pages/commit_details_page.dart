import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/domain/models/commit_tree_model.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commit_blob_use_case.dart';
import 'package:github_commit_history/domain/use_cases/github_use_cases/get_commit_tree_use_case.dart';
import 'package:github_commit_history/presentation/home/controllers/home_controller.dart';

class CommitDetailsPage extends StatelessWidget {
  final CommitTreeModel? widgetTree;
  final String? commitTitle;

  const CommitDetailsPage({
    required this.widgetTree,
    required this.commitTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.back();
        });
      },
      canPop: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppTheme.colors.white,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
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
                header(),
                body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.folderOpen,
              color: AppTheme.colors.appWarning,
              size: 40.r,
            ).paddingOnly(left: 24.w),
            Expanded(
              child: Text(
                commitTitle ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppTheme.colors.appPrimary,
                  fontSize: AppTheme.fontSize.f28,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ],
        ),
        heightSpace16,
      ],
    );
  }

  Widget body() {
    return (widgetTree != null)
        ? Expanded(
            child: SizedBox(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0.w,
                  mainAxisSpacing: 16.0.h,
                  childAspectRatio: 16.h / 5.8.h,
                ),
                itemCount: widgetTree?.tree.length ?? 0,
                itemBuilder: (context, index) {
                  CommitTreeNodeModel commitTreeNode = widgetTree!.tree[index];
                  return buildCommitTreeItem(commitTreeNode);
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
  }

  Widget buildCommitTreeItem(CommitTreeNodeModel commitTreeNodeModel) {
    HomeController homeController = Get.find<HomeController>();

    return GestureDetector(
      onTap: () async {
        if (commitTreeNodeModel.url.contains('blob')) {
          await homeController.getBlobCommit(
              title: commitTreeNodeModel.path,
              params: GetCommitBlobParams(commitTreeNodeModel.url));
        } else {
          await homeController.getTreeCommit(
              title: commitTreeNodeModel.path,
              params: GetCommitTreeParams(commitTreeNodeModel.url));
        }
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
          leading: FaIcon(
            (commitTreeNodeModel.type == 'tree')
                ? FontAwesomeIcons.folderOpen
                : FontAwesomeIcons.fileCode,
            color: (commitTreeNodeModel.type == 'tree')
                ? AppTheme.colors.appWarning
                : AppTheme.colors.appSuccess,
          ).paddingOnly(left: 14.w),
          contentPadding: EdgeInsets.zero,
          title: Text(
            commitTreeNodeModel.path,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.style.bold.copyWith(
              fontSize: AppTheme.fontSize.f12,
              color: AppTheme.colors.appPrimary,
            ),
          ).paddingOnly(top: 6.h),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightSpace4,
              Text(
                commitTreeNodeModel.type,
                style: TextStyle(
                  color: AppTheme.colors.appSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
