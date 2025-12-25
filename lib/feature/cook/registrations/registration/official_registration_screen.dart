import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class OfficialRegistration extends StatefulWidget {
  const OfficialRegistration({super.key});

  @override
  State<OfficialRegistration> createState() => _OfficialRegistrationState();
}

class _OfficialRegistrationState extends State<OfficialRegistration> {
  late final UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Get.find<UserController>();
  }

  String _getCurrentStatus() {
    final isKlzhRegistered = _userController.useModelData?.isKlzhRegistered ?? false;
    final pdfSent = _userController.useModelData?.pdfSent ?? false;

    if (isKlzhRegistered && pdfSent) {
      return "Completed";
    } else if (pdfSent && !isKlzhRegistered) {
      return "Pending Confirmation";
    } else {
      return "Not Started";
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('=============>>>> ${_userController.useModelData?.isKlzhRegistered ?? false}');
    debugPrint('=============>>>> ${_userController.useModelData?.pdfSent ?? false}');
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
            GetBuilder<UserController>(
                builder: (controller) {
                  //final currentStatus = _getCurrentStatus();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatusOption("Not Started", controller.useModelData?.pdfSent == true),
                      _buildStatusOption("Pending Confirmation", controller.useModelData?.isKlzhRegistered == true),
                      _buildStatusOption("Completed", false),
                    ],
                  );
                }
            ),

            GetBuilder<UserController>(
                builder: (controller) {
                  final currentStatus = _getCurrentStatus();
                  if(currentStatus == 'Pending Confirmation') {
                    return Column(
                      children: [
                        CustomText(
                          top: 44.h,
                          textAlign: TextAlign.start,
                          text: "Perfect! The MD-00029 form has been sent to KLZH. You will receive a confirmation email from us shortly. Now, please wait for an email from KLZH containing your official business number. This can take a few weeks.",
                          color: AppColors.black04TextColor,
                        ),
                        CustomText(
                          top: 10.h,
                          textAlign: TextAlign.start,
                          text: "⚠ Important: Once you receive your business number from KLZH, you have 7 days to enter it in this section. Your account will be temporarily blocked if the number is not added in time.",
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }
            ),

            const Spacer(),
            GetBuilder<UserController>(
                builder: (controller) {
                  final currentStatus = _getCurrentStatus();
                  return CustomButton(
                    onPressed: () {
                      String route = currentStatus == "Not Started"
                          ? AppRoutes.introductionScreen
                          : currentStatus == "Completed"
                          ? AppRoutes.complianceScreen
                          : AppRoutes.businessNumberScreen;
                      Get.toNamed(route);
                    },
                    label: "Start Registration",
                  );
                }
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(String status, bool isCompleted) {
    return Row(
      children: [
        Radio<String>(
          value: status,
          groupValue: _getCurrentStatus(),
          onChanged: null,
          activeColor: AppColors.primaryColor,
        ),
        CustomText(
          text: status,
          fontSize: 14.sp,
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
        if(isCompleted)
          CustomText(
            left: 4.r,
            text: 'completed',
            color: Colors.green,
            fontSize: 8.sp,
          ),
      ],
    );
  }
}