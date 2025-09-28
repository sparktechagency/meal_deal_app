import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/custom_app_bar.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

import '../../../../controllers/auth/auth_controller.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelance Agreement",backgroundColor: Colors.transparent,),
      body:SingleChildScrollView(
        child: Padding(padding: EdgeInsetsGeometry.all(16.r),
        
        child: Column(
          spacing: 15.h,
          children: [
          Align(alignment:Alignment.center,child:   CustomText(text: "Responsibility & Freelancer Agreement",textAlign: TextAlign.center,),),
            CustomText(text: "This contract makes it clear that:",textAlign: TextAlign.center,),
            CustomText(text: "1. Each provider must sign a Freelancer Agreement with us. This contract clearly defines responsibilities and ensures that liability stays with the provider.",color: AppColors.black04TextColor,textAlign: TextAlign.start),
            CustomText(text: "2. The platform takes no responsibility for hygiene, product safety, or legal compliance.",color: AppColors.black04TextColor,textAlign: TextAlign.start),
            CustomText(text: "3. The provider works fully on their own responsibility.",color: AppColors.black04TextColor,textAlign: TextAlign.start),
            CustomText(text: "4. This step is crucial for legal and business security of the platform.",color: AppColors.black04TextColor,textAlign: TextAlign.start),
            CustomText(text: "5. By placing this step first, we bind providers contractually to the platform right away.",color: AppColors.black04TextColor,textAlign: TextAlign.start),
            Row(
              children: [
                GetBuilder<AuthController>(
                    builder: (controller) {
                      return Checkbox(
                        value: controller.isChecked,
                        onChanged: (value) => controller.onChanged(value),
                        activeColor: AppColors.primaryColor,
                      );
                    }
                ),
                Expanded(
                  child: CustomText(
                    text: "I have read and understood the official Freelancing Aggrement.",
                    fontSize: 11.sp,maxline: 2,
                    textAlign: TextAlign.start,
                    // color: AppColors.textColor4D4D4D,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            CustomButton(onPressed: (){
              Get.toNamed(AppRoutes.confrimScreen);
            },label: "Continue Freelancing Agreement",fontSize: 16.sp,)
          ],
        ),),
      )
    );
  }
}