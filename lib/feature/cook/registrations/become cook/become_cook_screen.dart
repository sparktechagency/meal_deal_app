import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class BecomeCookScreen extends StatefulWidget {
  const BecomeCookScreen({super.key});

  @override
  State<BecomeCookScreen> createState() => _BecomeCookScreenState();
}

class _BecomeCookScreenState extends State<BecomeCookScreen> {

final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(
        title: "Become a Cook",

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              CustomText(
                text: "Tell Us Something About Yourself.",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,

              ),

              SizedBox(height: 6.h),

              CustomTextField(
                controller: _registrationsController.desController,
                hintText: "Tell Us Something About Yourself...",
                maxLines: 5,
                minLines: 5,
                contentPaddingHorizontal: 16.w,
                contentPaddingVertical: 12.h,
                maxLength: 200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filColor: Colors.white,
              ),

              CustomText(
                text: "Short Description About Your Cook",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,

              ),

              SizedBox(height: 6.h),

              // Description TextField
              CustomTextField(
                controller: _registrationsController.sortDesController,
                hintText: "I cook home made Moroccan food with love....",
                maxLines: 2,
                minLines: 2,
                contentPaddingHorizontal: 16.w,
                contentPaddingVertical: 12.h,
                maxLength: 80,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filColor: Colors.white,
              ),
              

              SizedBox(height: 10.h),

              // My Location Section
              _buildSectionCard(
                title: "My Location",
                child: CustomTextField(
                  hintText: 'Enter yo Location',
                    controller: _registrationsController.locationController),
              ),

              SizedBox(height: 20.h),

            ],
          ),
        ),
      ),
      bottomNavigationBar:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
              child: CustomButton(
                onPressed: () {
                 // Get.toNamed(AppRoutes.responsibilityContractScreen);
                  Get.toNamed(AppRoutes.verificationCertificationScreen);
                },
                label: "Next",

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.left,
            color: AppColors.darkColor,
          ),
          SizedBox(height: 6.h),
          child,
        ],
      ),
    );
  }
}