import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class OfficialRegistration extends StatefulWidget {
  const OfficialRegistration({super.key});

  @override
  State<OfficialRegistration> createState() => _OfficialRegistrationState();
}

class _OfficialRegistrationState extends State<OfficialRegistration> {
  late final AuthController _authController;
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    _authController = Get.find<AuthController>();
    _updateStatus();
  }

  void _updateStatus() {
    setState(() {
      currentStatus = _authController.cookUseModelData?.user?.isKlzhRegistered == true
          ? "Pending Confirmation"
          : "Not Started";
    });
  }

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
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusOption("Not Started"),
                _buildStatusOption("Pending Confirmation"),
                _buildStatusOption("Completed"),
              ],
            ),

            if(currentStatus == 'Pending Confirmation')...[
              CustomText(
                top: 44.h,
                textAlign: TextAlign.start,
                text: "Perfect! The MD-00029 form has been sent to KLZH. You will receive a confirmation email from us shortly. Now, please wait for an email from KLZH containing your official business number. This can take a few weeks.",color: AppColors.black04TextColor,),
              CustomText(
                top: 10.h,
                textAlign: TextAlign.start,
                text: "⚠ Important: Once you receive your business number from KLZH, you have 7 days to enter it in this section. Your account will be temporarily blocked if the number is not added in time.",),

            ],
            const Spacer(),
            CustomButton(
              onPressed: () {
                String route = currentStatus == "Not Started"
                    ? AppRoutes.introductionScreen
                    : currentStatus == "Completed"
                    ? AppRoutes.complianceScreen
                    : AppRoutes.businessNumberScreen;
                Get.toNamed(route);
              },
              label: "Start Registration",
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status) {
    return Row(
      children: [
        Radio<String>(
          value: status,
          groupValue: currentStatus,
          onChanged: (String? value) {
            setState(() {
              currentStatus = value ?? currentStatus;
            });
          },
          activeColor: AppColors.primaryColor,
        ),
        CustomText(text: status, fontSize: 14.sp),
        // CustomText(
        //   left: 4.r,
        //     text: 'completed',color: Colors.green,fontSize: 8.sp),
      ],
    );
  }
}