import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAnimationsController extends GetxController {
  // navbar:
  double navbarOpacity1 = 0, navbarOpacity2 = 0;
  // title:
  double titleOpacity = 0;
  EdgeInsets titlePadding = EdgeInsets.only(top: 20.h, left: 25);
  // tasks:
  double tasksTitleOpacity = 0;
  double notFoundOpacity = 0;
  // floating button:
  double floatingButtonOpacity = 0;

  // update void
  updateHomeAnimations(
      {double? newNavbarOpacity1,
      double? newNavbarOpacity2,
      double? newTitleOpacity,
      double? newTasksTitleOpacity,
      double? newNotFoundOpacity,
      double? newFloatingButtonOpacity,
      EdgeInsets? newTitlePadding}) {
    navbarOpacity1 = newNavbarOpacity1 ?? navbarOpacity1;
    navbarOpacity2 = newNavbarOpacity2 ?? navbarOpacity2;
    titleOpacity = newTitleOpacity ?? titleOpacity;
    tasksTitleOpacity = newTasksTitleOpacity ?? tasksTitleOpacity;
    notFoundOpacity = newNotFoundOpacity ?? notFoundOpacity;
    floatingButtonOpacity = newFloatingButtonOpacity ?? floatingButtonOpacity;
    titlePadding = newTitlePadding ?? titlePadding;
    update();
  }
}

startHomeAnimations() async {
  await Future.delayed(const Duration(milliseconds: 500));
  Get.find<HomeAnimationsController>().updateHomeAnimations(
    newNavbarOpacity1: 1,
  );
  await Future.delayed(const Duration(milliseconds: 200));
  Get.find<HomeAnimationsController>().updateHomeAnimations(
    newNavbarOpacity2: 1,
  );
  await Future.delayed(const Duration(milliseconds: 500));

  await Future.delayed(const Duration(milliseconds: 500));
  Get.find<HomeAnimationsController>().updateHomeAnimations(
    newTasksTitleOpacity: 1,
  );
  await Future.delayed(const Duration(milliseconds: 500));
  Get.find<HomeAnimationsController>().updateHomeAnimations(
    newNotFoundOpacity: 1,
  );
  await Future.delayed(const Duration(milliseconds: 500));
  Get.find<HomeAnimationsController>().updateHomeAnimations(
    newFloatingButtonOpacity: 1,
  );
}
