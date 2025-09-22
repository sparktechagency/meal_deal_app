import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/utils/app_colors.dart';
import '../../feature/profile/widgets/profile_list_tile.dart';
import '../../custom_assets/assets.gen.dart';
import '../../routes/app_routes.dart';
import '../../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        title: 'My Account',
      ),
      body: Column(
        children: [
          CustomContainer(
            height: 150.h,
            child: Stack(
              children: [
                CustomContainer(
                  alignment: Alignment.bottomCenter,
                  height: 90.h,
                  width: double.infinity,
                  color: AppColors.primaryColor,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CustomImageAvatar(radius: 50.r, image: ''),
                      CustomText(
                        text: 'Tanvir Hridoy',
                        color: AppColors.black400TextColor,
                        fontSize: 20.sp,
                      ),
                      CustomText(
                        text: 'tanvirhridoy@gmail.com',
                        color: AppColors.black400TextColor,
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
          // List of Options
          ProfileListTile(
            icon: Assets.icons.profileEdit.svg(),
            title: "Edit Profile",
            onTap: () {
              Get.toNamed(AppRoutes.editProfileScreen);
            },
          ),
          ProfileListTile(
            icon: Assets.icons.favourite.svg(),
            title: "Favourite",
            onTap: () {
              // Get.toNamed(AppRoutes.settingScreen);
            },
          ),
          ProfileListTile(
            icon: Assets.icons.setting.svg(),
            title: "Settings",
            onTap: () {
              Get.toNamed(AppRoutes.settingScreen);
            },
          ),

          ProfileListTile(
            icon: Assets.icons.support.svg(),
            title: "Support Center",
            onTap: () {
              Get.toNamed(AppRoutes.settingScreen);
            },
          ),

          Spacer(),
          /// Log Out Button
          ProfileListTile(
            textColor: AppColors.errorColor,
            color:  AppColors.errorColor,
            icon: Assets.icons.logout.svg(),
            title: "log out",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(
                  title: "Do you want to log out your profile?",
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    //Get.offAllNamed(AppRoutes.loginScreen);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
