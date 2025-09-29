import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Confirmation Screen",backgroundColor: Colors.transparent,),
      body: Padding(padding: EdgeInsetsGeometry.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30.h,
        children: [
          Image.asset(Assets.images.confirmImage.path,height: 100.h,),
          CustomText(text: "You have successfully read the Hygiene Guideline"),
          SizedBox(height: 30.h,),
          CustomButton(onPressed: (){
           Get.toNamed(AppRoutes.becomeCookScreen);
          },label: "Next",fontSize: 16.sp,)
        ],
      ),)
    );
  }
}