import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class WaitingApprovalScreen extends StatelessWidget {
  const WaitingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: "", backgroundColor: Colors.transparent),
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
            CustomText(text: "Waiting for Admin’s Approval..."),
            SizedBox(height: 60.h),
            CustomButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.cookBottomNavBar);
              },
              label: "Next",
            ),
          ],
        ),
      ),
    );
  }
}
