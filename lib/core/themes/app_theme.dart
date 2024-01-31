library app_theme;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'src/color_theme.dart';
part 'src/style_theme.dart';
part 'src/sized_box_theme.dart';
part 'src/images_theme.dart';

class AppTheme {
  static AppFontSize get fontSize => AppFontSize();
  static AppStyle get style => AppStyle();
  static AppColors get colors => AppColors();
}
