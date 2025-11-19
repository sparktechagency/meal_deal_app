import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/feature/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';

import '../../../controllers/auth/auth_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/widgets.dart';
import '../widgets/app_logo.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final String role = Get.arguments['role'];
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLogo(
              title: 'Enter Verification Code.',
              subtitle:
                  'Please enter the 6 digit verification code sent  to your e-mail or phone number.',
            ),
            SizedBox(height: 40.h),

            ///==============Pin code Field============<>>>>
            Form(
              key: _globalKey,
              child: Center(
                child: CustomPinCodeTextField(
                  textEditingController: _authController.otpController,
                ),
              ),
            ),

            SizedBox(height: 80.h),
            GetBuilder<AuthController>(
              builder: (controller) {
                return controller.isLoadingOtp
                    ? CustomLoader()
                    : CustomButton(
                      label: "Verify",
                      onPressed: _onTapNextScreen,
                    );
              },
            ),
            // CustomButton(
            //   label: "Continue",
            //   onPressed: _onTapNextScreen,
            // ),
            SizedBox(height: 18.h),
          ],
        ),
      ),
    );
  }

  void _onTapNextScreen() async {
    if (!_globalKey.currentState!.validate()) return;


    final bool isSuccess = await _authController.verifyOTP();
    if (isSuccess) {
      if (role == 'cook') {
        Get.offAllNamed(AppRoutes.cookBottomNavBar);
        Get.find<CustomBottomNavBarController>().selectedIndex.value = 0;
      } else if(role == 'forgot'){
        Get.toNamed(AppRoutes.resetPasswordScreen);
      } else {
        Get.offAllNamed(AppRoutes.userBottomNavBar);
        Get.find<CustomBottomNavBarController>().selectedIndex.value = 0;
      }
    }
  }


}
