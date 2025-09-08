import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/utils/app_colors.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/widgets.dart';
import '../widgets/app_logo.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();



  final AuthController _registerController = Get.find<AuthController>();


  String selectedValueType = 'professional';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLogo(
                spacing: 0,
                title: 'Create Account',
                subtitle: 'Please tell us more about you',
              ),

              SizedBox(height: 24.h),
              CustomTextField(
                labelText: 'Full Name',
                controller: _registerController.emailController,
                hintText: "Enter Your full name",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
              CustomTextField(
                labelText: 'Phone Number',
                controller: _registerController.emailController,
                hintText: "Enter Your phone Number",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
              CustomTextField(
                labelText: 'Email',
                controller: _registerController.emailController,
                hintText: "Enter Your Email Address",
                keyboardType: TextInputType.emailAddress,
                isEmail: true,
              ),
              CustomTextField(
                labelText: 'Password',
                controller: _registerController.passwordController,
                hintText: "Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (_registerController.passwordController.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },
              ),
              CustomTextField(
                labelText: 'Confirm Password',
                controller: _registerController.confirmPassController,
                hintText: "Confirm Password",
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm password is required';
                  } else if (value != _registerController.passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
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
                  CustomText(
                    text: "I accept the Terms & Conditions & Privacy Policy",
                    fontSize: 11.sp,
                   // color: AppColors.textColor4D4D4D,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingRegister ? CustomLoader() : CustomButton(label: "Sign Up", onPressed: _onSignUp);
                }
              ),
              SizedBox(height: 24.h),

              Center(

                  child: CustomText(
                    bottom: 10.h,
                    text: 'Or continue with',color: AppColors.appGreyColor,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){}, icon: Assets.icons.google.svg()),
                  SizedBox(width: 8.w),
                  IconButton(onPressed: (){}, icon: Assets.icons.apple.svg()),
                ],),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    color: AppColors.grayShade100,
                    text: "Already have an account?  ",
                    fontSize: 14.sp,
                  ),
                  CustomText(
                    onTap: () {
                     Get.offAllNamed(AppRoutes.loginScreen);
                    },
                    text: "Sign In",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }
  void _onSignUp() {
    if (!_globalKey.currentState!.validate()) return;
    if (!_registerController.isChecked) {
      showToast('Please check the privacy policy');
      return;
    }
    //_registerController.register();
  }



}
