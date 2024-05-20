


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/shared/styles/colors.dart';

class TextStyles{

  static TextStyle errorText = TextStyle(
    fontSize: 12.sp,
    color: Colors.redAccent
  );

  static TextStyle font24DarkBlack700 = TextStyle(
    fontSize: 24.sp,
    color: ColorManager.darkBlack,
    fontWeight: FontWeight.w700
  );

  static TextStyle font19White700 = TextStyle(
      fontSize: 19.sp,
      color: Colors.white,
      fontWeight: FontWeight.w700
  );

  static TextStyle font14Grey400 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.grey,
      fontWeight: FontWeight.w400
  );

  static TextStyle font14LightGrey400 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.lightGrey,
      fontWeight: FontWeight.w400
  );

  static TextStyle font14LightGrey1400 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.lightGrey1,
      fontWeight: FontWeight.w400
  );

  static TextStyle font14LightGrey1700 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.lightGrey1,
      fontWeight: FontWeight.w700
  );

  static TextStyle font14Default700 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.defaultColor,
      fontWeight: FontWeight.w700
  );

  static TextStyle font14LightBlack500 = TextStyle(
      fontSize: 14.sp,
      color: ColorManager.lightBlack,
      fontWeight: FontWeight.w500
  );

}