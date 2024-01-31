// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/buttons/primary_button.dart';
import 'package:github_commit_history/core/widgets/inputs/app_inputs.dart';
import 'package:github_commit_history/presentation/home/controllers/home_controller.dart';

class GitHubRepoForm extends StatefulWidget {
  final String? initialOwner;
  final String? initialRepo;
  final Function() searchButton;

  const GitHubRepoForm({
    Key? key,
    this.initialOwner,
    this.initialRepo,
    required this.searchButton,
  }) : super(key: key);

  @override
  _GitHubRepoFormState createState() => _GitHubRepoFormState();
}

class _GitHubRepoFormState extends State<GitHubRepoForm> {
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('SEARCH_COMMIT_HISTORY'.tr,
              style: AppTheme.style.bold.copyWith(
                fontSize: AppTheme.fontSize.f20,
                color: AppTheme.colors.appPrimary,
              )),
          heightSpace20,
          AppTextField(
            inputsParams: AppInputParameters(
              controller: homeController.ownerController,
              hintText: 'OWNER'.tr,
              inputType: AppInputType.email,
            ),
          ),
          heightSpace8,
          AppTextField(
            inputsParams: AppInputParameters(
              controller: homeController.repoController,
              hintText: 'REPO'.tr,
              inputType: AppInputType.text,
            ),
          ),
          heightSpace16,
          PrimaryButton(
            svgAsset: 'assets/svg/github-mark-white.svg',
            text: 'SEARCH'.tr,
            color: AppTheme.colors.appPrimary,
            onPressed: widget.searchButton,
          ),
        ],
      ),
    );
  }
}
