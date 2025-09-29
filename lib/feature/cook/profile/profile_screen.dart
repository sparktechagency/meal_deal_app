import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../widgets/widgets.dart';
import '../../profile/widgets/profile_list_tile.dart';


class CookProfileScreen extends StatelessWidget {
  const CookProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomContainer(
              height: 210.h,
              child: Stack(
                children: [
                  CustomContainer(
                    image: DecorationImage(image: AssetImage(Assets.images.profileCover.path)),
                    alignment: Alignment.bottomCenter,
                   height: 151.h,
                    width: double.infinity,
                    //color: AppColors.primaryColor,
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
        

            CustomContainer(
              radiusAll: 8.r,
              marginAll: 16.r,
              paddingAll: 16.r,
              color: AppColors.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: 'Your wallet',color: Colors.white,bottom: 4.h),
                      CustomText(text: '\$820.00',fontSize: 16.sp,color: Colors.white,),
                    ],
                  ),
                  CustomButton(
                    height: 33.h,
                      width: 106.w,
                      backgroundColor: Colors.transparent,
                      onPressed: (){},label: 'Withdraw',fontSize: 14.sp,foregroundColor: Colors.white,bordersColor: Colors.white)
                ],
              ),
            ),
            // List of Options
            ProfileListTile(
              icon: Assets.icons.profileEdit.svg(),
              title: "Edit Profile",
              onTap: () {
                Get.toNamed(AppRoutes.editProfileScreen);
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
                Get.toNamed(AppRoutes.supportScreen);
              },
            ),
        
            Spacer(),
            /// Log Out Button...
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
      ),
    );
  }
}
