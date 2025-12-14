import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

import '../../../../custom_assets/assets.gen.dart';


class RegistrationCompletedScreen extends StatelessWidget {
  const RegistrationCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Registration Completed",backgroundColor: Colors.transparent,),
      
      body: Padding(padding: EdgeInsetsGeometry.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15.h,
          children: [
            Image.asset(Assets.images.verified.path,height: 150.h),
            CustomText(text: "Verified",fontSize: 25.sp,),
            CustomText(text: "Thank you. Your registration with the health authorities is now complete and verified.",),
            // SizedBox(height: 60.h,),
            // CustomButton(onPressed: (){},label: "Next",),

          ],
        ),),
    );
  }
}