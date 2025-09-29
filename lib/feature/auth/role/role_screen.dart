import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/custom_button.dart';
import 'package:meal_deal_app/widgets/custom_scaffold.dart';
import 'package:meal_deal_app/widgets/custom_text.dart';

import '../../../custom_assets/assets.gen.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 24.w,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Assets.images.img3.image(height: 317.h, width: 317.w),
          CustomText(
            top: 44.h,
            text: 'Choose Your Role to Get Started',
            color: AppColors.primaryColor,
            fontSize: 20.sp,
          ),
          Spacer(),
          CustomButton(
            onPressed: () {
              Get.toNamed(AppRoutes.loginScreen,arguments: 'cook');
            },
            label: 'I want to Cook',
          ),
          SizedBox(height: 16.h),
          CustomButton(
            foregroundColor: AppColors.black300TextColor,
            bordersColor: AppColors.primaryColor,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Get.toNamed(AppRoutes.loginScreen,arguments: 'user');
            },
            label: 'I want  Food',
          ),
          Spacer(),
        ],
      ),
    );
  }
}
