import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/animations/animations.dart';
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
    startHomeAnimations();
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
        Text(
          commitTitle ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.colors.appPrimary,
            fontSize: AppTheme.fontSize.f36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget body() {
    return (widgetTree != null)
        ? Expanded(
            child: SizedBox(
              child: ListView.separated(
                separatorBuilder: (context, index) => heightSpace16,
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

    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) async {
              //TODO CHANGE TOO
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
            title: Text(commitTreeNodeModel.path,
                style: AppTheme.style.bold.copyWith(
                  fontSize: AppTheme.fontSize.f16,
                  color: AppTheme.colors.appPrimary,
                )).paddingOnly(top: 4.h),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpace4,
                heightSpace2,
                Text(
                  commitTreeNodeModel.path,
                  style: TextStyle(
                    color: AppTheme.colors.appSecondary,
                  ),
                ),
                Text(
                  commitTreeNodeModel.type,
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
