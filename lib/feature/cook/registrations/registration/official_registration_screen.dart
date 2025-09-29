import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class OfficialRegistration extends StatefulWidget {
  const OfficialRegistration({super.key});

  @override
  State<OfficialRegistration> createState() => _OfficialRegistrationState();
}

class _OfficialRegistrationState extends State<OfficialRegistration> {
  String? currentStatus = "Not Started";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Official Registration",
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Your Current Status",
              fontSize: 16.sp, // Responsive font size
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: "Not Started",
                      groupValue: currentStatus,
                      onChanged: (String? value) {
                        setState(() {
                          currentStatus = value;
                        });
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    CustomText(text: "Not Started", fontSize: 14.sp),
                  ],
                ),

                Row(
                  children: [
                    Radio<String>(
                      value: "Pending Confirmation",
                      groupValue: currentStatus,
                      onChanged: (String? value) {
                        setState(() {
                          currentStatus = value;
                        });
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    CustomText(text: "Pending Confirmation", fontSize: 14.sp),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Completed",
                      groupValue: currentStatus,
                      onChanged: (String? value) {
                        setState(() {
                          currentStatus = value;
                        });
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    CustomText(text: "Completed", fontSize: 14.sp),
                  ],
                ),
              ],
            ),
            Spacer(),

            // Start Registration Button
            CustomButton(
              onPressed: () {
               Get.toNamed( currentStatus=="Not Started"? AppRoutes.introductionScreen : currentStatus=="Completed"? AppRoutes.complianceScreen:AppRoutes.businessNumberScreen);
              },
              label: "Start Registration",
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
