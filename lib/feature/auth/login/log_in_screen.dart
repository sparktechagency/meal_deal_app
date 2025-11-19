import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../app/utils/app_colors.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/widgets.dart';
import '../widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final String role = Get.arguments as String;

  final _authType = [
    {'label': 'Phone', 'value': 'phone'},
    {'label': 'Email', 'value': 'email'},
  ];

  String selectedValue = 'phone';

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final isPhone = selectedValue == 'phone';
    return CustomScaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLogo(
                title: 'Sign In ',
                subtitle: 'Don’t have an account ? Create an account.',
              ),

              SizedBox(height: 24.h),

              TwoButtonWidget(buttons: _authType, selectedValue: selectedValue, onTap: (value){
                selectedValue = value;
                setState(() {});
              }),
              SizedBox(height: 24.h),
              CustomTextField(
                labelText: isPhone ? 'Phone' : 'Email',
                controller: _authController.loginEmailController,
                hintText: isPhone ? "Enter Your phone Number" : "Enter Your email",
                keyboardType: isPhone ? TextInputType.number : TextInputType.emailAddress,
                isEmail: isPhone ? false : true,
              ),
              CustomTextField(
                labelText: 'Password',
                controller: _authController.loginPasswordController,
                hintText: "Password",
                //isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  } else if (_authController.loginPasswordController.text.length < 8) {
                    return 'Password must be 8+ chars';
                  }
                  return null;
                },

              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  decoration: TextDecoration.underline,
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotScreen);
                  },
                  text: "Forgot Password",
                ),
              ),
              SizedBox(height: 80.h),
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingLogin ? CustomLoader() : CustomButton(
                    label: "Sign In",
                    onPressed: _onSingUp,
                  );
                }
              ),
              // CustomButton(
              //   label: "Sign In",
              //   onPressed: _onSingUp,
              // ),

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

              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don’t have any account?  ",
                    fontSize: 14.sp,
                    color: AppColors.appGreyColor,
                  ),
                  CustomText(
                    onTap: () {
                      Get.offAllNamed(AppRoutes.signUpScreen, arguments: role);
                    },
                    text: "Sign Up",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSingUp() {
    if (!_globalKey.currentState!.validate()) return;
    // if(role == 'user'){
    //   Get.offAllNamed(AppRoutes.userBottomNavBar);
    // }else{
    //   Get.offAllNamed(AppRoutes.cookBottomNavBar);
    // }
   _authController.login();
  }

}
