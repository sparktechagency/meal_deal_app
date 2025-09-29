import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';

class CookViewScreen extends StatelessWidget {
  const CookViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
          children: [
            _buildContent(),
            _buildAppBar(),
          ]),
    );
  }

  /// Main Scrollable Content
  Widget _buildContent() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              CustomContainer(
                height: 370.h,
                width: double.infinity,
                child: Assets.images.cookImage.image(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              SizedBox(height: 70.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CategoryItemWidget(categoryItem: HelperData.categoryItem,),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 16.h, bottom: 40.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _menuCardWidget();
                },
              ),
            ],
          ),
          Positioned(
            top: 280.h,
            left: 24.w,
            right: 24.w,
            child: _buildProfileHeader(),
          ),
        ],
      ),
    );
  }

  Widget _menuCardWidget() {
    return CustomContainer(
      onTap: (){
        Get.toNamed(AppRoutes.productDetailsScreen);
      },
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: Offset(0, 1),
          blurRadius: 5,
        ),
      ],
      verticalMargin: 6.h,
      horizontalMargin: 16.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        children: [
          Assets.images.img.image(width: 70.w, height: 70.w, fit: BoxFit.cover),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: 'Fondue', fontSize: 16.sp),
                CustomText(
                  text: "\$12.52",
                  color: AppColors.primaryColor,
                  top: 2.h,
                  bottom: 6.h,
                ),
                Row(
                  children: [
                    Assets.icons.star.svg(),
                    CustomText(text: " 4.2 (232)", fontSize: 12.sp),
                  ],
                ),
              ],
            ),
          ),

          // Add Button
          ElevatedButton.icon(
            onPressed: () {
              Get.toNamed(AppRoutes.cardScreen);
            },
            icon: Icon(Icons.shopping_cart, size: 14.r),
            label: CustomText(text: "Add", fontSize: 12.sp),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.black600TextColor,
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.black600TextColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Profile Header Card
  Widget _buildProfileHeader() {
    return CustomContainer(
      paddingAll: 16.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Jacob Jones",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Assets.icons.star.svg(),
              Flexible(child: CustomText(text: " 4.5 (232) • 13 km")),
            ],
          ),
          Divider(
            color: AppColors.black04TextColor,
            thickness: 0.5,
            height: 24.h,
          ),
          CustomText(
            text: "Why I cook?",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            text: "Lorem ipsum dolor sit amet consectetur.",
            color: AppColors.colorA0A0A0,
          ),
        ],
      ),
    );
  }

  /// Transparent App Bar
  Widget _buildAppBar() {
    return Positioned(
      top: 0.h,
      left: 0.w,
      right: 0.w,
      child: CustomAppBar(
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(onTap: () {}, child: Assets.icons.love.svg()),
          IconButton(onPressed: () {
            Get.toNamed(AppRoutes.cookDetailsScreen);
          }, icon: Assets.icons.info.svg()),
        ],
      ),
    );
  }
}
