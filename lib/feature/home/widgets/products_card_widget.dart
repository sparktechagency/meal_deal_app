import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class ProductsCardWidget extends StatelessWidget {
  const ProductsCardWidget({
    super.key,
    this.image,
    this.title,
    this.authorImage,
    this.author,
    this.rating,
    this.distance,
    this.kcal,
    this.portions,
    this.index, required this.mealsId,
  });

  final String? image;
  final String mealsId;
  final String? title;
  final String? authorImage;
  final String? author;
  final String? rating;
  final String? distance;
  final String? kcal;
  final int? portions;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        Get.toNamed(AppRoutes.productDetailsScreen,arguments: mealsId);
      },
      marginRight: index == null ? 0 : 14.w,
      marginLeft: (index == null) ? 0 : (index == 0 ? 14.w : 0),
      radiusAll: 8.r,
      height: 265.h,
      width: 166.w,
      color: AppColors.bgColor,
      bordersColor: AppColors.borderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 136.h,
            width: double.infinity,
            child: CustomNetworkImage(
              borderRadius: 8.r,
                backgroundColor: AppColors.bgColor,
                height: 136.h,
                width: double.infinity,
                fit: BoxFit.contain,
                imageUrl: image ?? ''),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    textAlign: TextAlign.start,
                    maxline: 1,
                    textOverflow: TextOverflow.ellipsis,
                    text: title ?? '',
                    bottom: 6.h,
                    fontSize: 14.sp),

                // Author
                Row(
                  children: [
                    CustomImageAvatar(
                        radius: 11.r,
                        image: authorImage ?? ''),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: CustomText(
                          maxline: 1,
                          textOverflow: TextOverflow.ellipsis,
                          text: author ?? '',
                          fontSize: 12.sp),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Rating + Distance
                Row(
                  children: [
                    Assets.icons.star.svg(height: 14.h, width: 14.w),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(
                            left: 2.w,
                            text: " ${rating ?? '0.0'}   •",
                            fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.location_on,
                        size: 14.sp, color: AppColors.black600TextColor),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(
                            text: distance ?? '',
                            fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Kcal + Portions
                Row(
                  children: [
                    Icon(Icons.local_fire_department,
                        size: 14.sp, color: AppColors.primaryColor),
                    Flexible(
                      child: CustomText(
                          text: "${kcal ?? '0.0'} kcal",
                          fontSize: 11.sp,
                          color: AppColors.primaryColor),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(
                            text: "${portions ?? '0.0'} portions left",
                            fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}