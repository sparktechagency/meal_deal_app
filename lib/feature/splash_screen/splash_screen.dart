import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/utils/app_colors.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  void _goNextScreen() {
    Future.delayed(const Duration(seconds: 2), () async {
     Get.offAllNamed(AppRoutes.onboardingScreen);
    });
  }

  @override
  void initState() {
   _goNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashColor,
      body: Center(
        child: Assets.images.splashLogo.image(height: 170.h,width: 183.w),
      ),
    );
  }
}
