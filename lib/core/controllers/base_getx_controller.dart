import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_commit_history/core/themes/app_theme.dart';

class BaseGetxController extends GetxController {
  closeLoading() => EasyLoading.dismiss();

  showLoading([String? customText]) {
    EasyLoading.show(
      status: customText ?? 'LOADING'.tr,
      maskType: EasyLoadingMaskType.black,
    );
  }

  void showSuccessMessage(String title, String message) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: AppTheme.colors.appSuccess,
      icon: const Center(
        child: FaIcon(
          FontAwesomeIcons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  void showInfoMessage(String title, String subtitle) {
    Get.snackbar(
      title,
      subtitle,
      backgroundColor: AppTheme.colors.appPrimary,
      colorText: AppTheme.colors.appBlackGrey,
      icon: Center(
        child: FaIcon(
          FontAwesomeIcons.circleExclamation,
          color: AppTheme.colors.appBlackGrey,
        ),
      ),
    );
  }

  void showErrorMessage(String title, String subtitle) {
    Get.snackbar(
      title,
      subtitle,
      colorText: Colors.white,
      backgroundColor: Colors.redAccent.shade100,
      icon: const Center(
        child: FaIcon(
          FontAwesomeIcons.circleExclamation,
          color: Colors.white,
        ),
      ),
    );
  }
}
