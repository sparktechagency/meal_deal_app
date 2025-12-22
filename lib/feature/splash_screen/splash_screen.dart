import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/prefs_helper.dart';
import 'package:meal_deal_app/app/utils/app_constants.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import '../../app/utils/app_colors.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  void _goNextScreen() async{
    String barrerTocken = await PrefsHelper.getString(AppConstants.bearerToken);
    String role = await PrefsHelper.getString(AppConstants.role);

    Future.delayed(const Duration(seconds: 2), () async {
      if( barrerTocken.isNotEmpty){
        if( role == 'user'){
          Get.offAllNamed(AppRoutes.userBottomNavBar);
        }else{
          if(Get.find<UserController>().useModelData?.isCookfullyVerified == true){
            Get.offAllNamed(AppRoutes.cookBottomNavBar);
          }else{
            Get.offAllNamed(AppRoutes.roleScreen);
          }
        }
      }else{
        Get.offAllNamed(AppRoutes.onboardingScreen);
      }
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
