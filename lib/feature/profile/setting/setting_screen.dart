import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/feature/profile/widgets/profile_list_tile.dart';
import '../../../app/utils/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        title: 'Settings'),
      body: Column(
        children: [
          SizedBox(height: 32.h),


          ProfileListTile(
            icon: Assets.icons.password.svg(),
            title: 'Change Password',
            onTap: () {
              Get.toNamed(AppRoutes.changePassScreen);
            },
          ),



          ProfileListTile(
            icon: Assets.icons.terms.svg(),
            title: 'Terms & Condition',
            onTap: () {
              Get.toNamed(AppRoutes.termsScreen);
            },
          ),



          ProfileListTile(
            icon: Assets.icons.policy.svg(),
            title: 'Privacy Policy',
            onTap: () {
              Get.toNamed(AppRoutes.policyScreen);
            },
          ),



          ProfileListTile(
            icon: Assets.icons.about.svg(),
            title: 'About Us',
            onTap: () {
              Get.toNamed(AppRoutes.aboutScreen);
            },
          ),




          Spacer(),
          ProfileListTile(
            textColor: AppColors.errorColor,
            color:  AppColors.errorColor,
            icon: Assets.icons.delete.svg(),
            title: 'Delete Account',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  title: "Do you want to delete your account?",
                  confirmButtonText: 'Delete',
                  confirmButtonColor: AppColors.errorColor,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    //Get.offAllNamed(AppRoutes.signUpScreen);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

}
