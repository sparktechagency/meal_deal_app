import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class HygieneCourseScreen extends StatelessWidget {
  const HygieneCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),

            // Title
            CustomText(
              text: "Verification & Approval",
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
              color: AppColors.darkColor,
            ),

            SizedBox(height: 12.h),

            // Subtitle
            CustomText(
              text: "Get verified for unlimited dish uploads & sales",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.left,
              color: Colors.grey[600],
            ),

            SizedBox(height: 60.h),

            // Course Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Course Title
                  CustomText(
                    text: "Short online hygiene course",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    color: AppColors.darkColor,
                  ),

                  // Mandatory Badge
                  CustomText(
                    text: "(Mandatory)",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    color: AppColors.darkColor,
                  ),

                  SizedBox(height: 40.h),

                  // Start Button
                  CustomButton(
                    onPressed: () {
                     Get.toNamed(AppRoutes.startCourseScreen);
                    },
                    label: "Start",
                    backgroundColor: Color(0xFFE67E22),
                    foregroundColor: Colors.white,
                    height: 50.h,
                    width: 200.w,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    radius: 8.r,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}