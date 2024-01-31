import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
import 'package:github_commit_history/core/widgets/animations/animations.dart';
import 'package:github_commit_history/domain/models/commit_blob_model.dart';

class CommitBlobPage extends StatelessWidget {
  final CommitBlobModel? widgetBlob;
  final String? fileTitle;

  const CommitBlobPage({
    required this.widgetBlob,
    required this.fileTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    startHomeAnimations();
    return Scaffold(
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
    );
  }

  Widget header() {
    return Column(
      children: [
        Text(
          fileTitle ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.colors.appPrimary,
            fontSize: AppTheme.fontSize.f36,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'This content is encoded',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.colors.appPrimary,
            fontSize: AppTheme.fontSize.f20,
            fontWeight: FontWeight.bold,
          ),
        ),
        heightSpace10,
      ],
    );
  }

  Widget body() {
    String base64String = '';

    List<int> bytes = base64.decode(base64String);

    String decodedString = utf8.decode(bytes);

    //var content1 = Base64Decoder(widgetBlob!.content);

    return (widgetBlob != null)
        ? Expanded(
            child: SizedBox(
              child:
                  Text(widgetBlob!.content).paddingSymmetric(horizontal: 16.w),
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
}
