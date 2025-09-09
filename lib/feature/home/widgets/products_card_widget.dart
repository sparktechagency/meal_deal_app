import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class ProductsCardWidget extends StatelessWidget {
  const ProductsCardWidget({
    super.key,
    required this.item, required this.index,
  });

  final Map<String, dynamic> item;
  final int  index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      marginRight: 14.w,
      marginLeft: index == 0 ? 14.w : 0,
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
            child: item['image'],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:  10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    textAlign: TextAlign.start,
                    maxline: 1,
                    textOverflow: TextOverflow.ellipsis,
                    text: item["title"],
                    bottom: 6.h,
                    fontSize: 14.sp),

                // Author
                Row(
                  children: [
                    CustomImageAvatar(
                        radius: 11.r, image: item["authorImage"]),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: CustomText(
                          maxline: 1,
                          textOverflow: TextOverflow.ellipsis,
                          text: item["author"],
                          fontSize: 12.sp),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                // Rating + Distance
                Row(
                  children: [
                    Assets.icons.star.svg(height: 14.h,width: 14.w),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(
                            left: 2.w,
                            text:"${item["rating"]} (${item["reviews"]})   •",
                            fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.location_on,
                        size: 14.sp, color: AppColors.black600TextColor),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(text: item["distance"],
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
                      child: CustomText(text:"${item["kcal"]} kcal",
                          fontSize: 11.sp,color: AppColors.primaryColor),
                    ),
                    SizedBox(width: 8.w),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(text:"${item["portions"]} portions left",
                            fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),                    ],
      ),
    );
  }
}
