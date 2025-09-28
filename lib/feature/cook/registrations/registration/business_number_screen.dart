import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/custom_app_bar.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class BusinessNumberScreen extends StatelessWidget {
  const BusinessNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Enter Your Business Number",
        backgroundColor: Colors.transparent,
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16.h),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "Please enter the business number you received from KLZH in the mail to complete your registration.",
              textAlign: TextAlign.start,
            ),

            CustomText(text: "Enter Your Business Number"),

            CustomTextField(
              controller: TextEditingController(),
              hintText: "KLZH Business Number",
            ),

            Spacer(),
            CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.registrationCompletedScreen);
              },
              label: "Submit and Complete Registration",
            ),
            SizedBox(height: 30.h,)
          ],
        ),
      ),
    );
  }
}
