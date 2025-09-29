import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class RegistrationSubmittedScreen extends StatelessWidget {
  const RegistrationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Registration Submitted",backgroundColor: Colors.transparent,),
      body: Padding(padding: EdgeInsetsGeometry.all(20.h),
      child: Column(

        spacing: 35.h,
        children: [
          CustomText(text: "Perfect! The MD-00029 form has been sent to KLZH. You will receive a confirmation email from us shortly. Now, please wait for an email from KLZH containing your official business number. This can take a few weeks.",color: AppColors.black04TextColor,),
          Image.asset(Assets.images.confirmImage.path,height: 100.h,),
          CustomText(text: "⚠ Important: Once you receive your business number from KLZH, you have 7 days to enter it in this section. Your account will be temporarily blocked if the number is not added in time.",textAlign: TextAlign.start,),

        ],
      ),)
    );
  }
}