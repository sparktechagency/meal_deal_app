import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/fonts.gen.dart';

void showToast(String message, {int? seconds}) {
  Get.snackbar(
    "System Notification",
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.transparent,
    colorText: Colors.white,
    duration: Duration(seconds: seconds ?? 3),
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    borderRadius: 16.r,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    titleText: Padding(
      padding: EdgeInsets.only(left: 16.w, top: 8.h),
      child: Text(
        "System Notification",
        style: TextStyle(
          color: Colors.black,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
            ),
          ],
        ),
      ),
    ),
    messageText: ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.sp,
              fontFamily: FontFamily.lora,
              //fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
    padding: EdgeInsets.zero,
  );
}



class ToastMessageHelper {
}

// Usage - Super Simple with Glass Effect!
// ToastMessageHelper.showToastMessage("Login successful!");
// ToastMessageHelper.showToastMessage("Data loaded");
// ToastMessageHelper.showToastMessage("Something went wrong!");
// ToastMessageHelper.showToastMessage("Profile updated", seconds: 5);