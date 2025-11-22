import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/widgets.dart';
import '../widgets/app_logo.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AuthController _authController = Get.find<AuthController>();



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar:  CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             // SizedBox(height: 24.h),
              AppLogo(
                title: 'Forget Your Password?',
                subtitle: 'Enter Your Phone Number or Email to reset Password',
              ),
              SizedBox(height: 40.h),
              CustomTextField(
                labelText: 'Phone Number or Email',
                controller: _authController.forgotEmailController,
                hintText: "Enter your phone number or email",
                keyboardType: TextInputType.emailAddress,
                //isEmail: true,
              ),
              SizedBox(height: 36.h),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingForgot ? CustomLoader() : CustomButton(
                    label: "Continue",
                    onPressed: _onGetVerificationCode,
                  );
                }
              ),

              // CustomButton(
              //   label: "Continue",
              //   onPressed: _onGetVerificationCode,
              // ),
              SizedBox(height: 18.h),
            ],
          ),
        ),
      ),
    );
  }


  void _onGetVerificationCode(){
    if(!_globalKey.currentState!.validate()) return;
    // Get.toNamed(AppRoutes.otpScreen);
    _authController.forgot();
  }

}
