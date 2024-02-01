import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';
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
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.fileCode,
              color: AppTheme.colors.appSuccess,
              size: 40.r,
            ).paddingOnly(left: 24.w),
            Expanded(
              child: Text(
                fileTitle ?? '',
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
    String encodedString = widgetBlob?.content ?? '';
    String decodedString = '';

    String cleanedString =
        encodedString.replaceAll('\n', '').replaceAll(' ', '').trim();
    List<int> decodedBytes = base64.decode(cleanedString);
    decodedString = utf8.decode(decodedBytes);

    return (widgetBlob != null)
        ? Expanded(
            child: RawScrollbar(
              thumbColor: AppTheme.colors.appTertiary,
              thickness: 10,
              thumbVisibility: true,
              padding: EdgeInsets.only(right: 3.w),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.colors.appSecondary,
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
                  child: Text(
                    decodedString,
                    textAlign: TextAlign.justify,
                    style: AppTheme.style.regular.copyWith(
                      color: AppTheme.colors.white,
                    ),
                  ).paddingSymmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                ),
              ),
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
