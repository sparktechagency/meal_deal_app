import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class CooksCardWidget extends StatelessWidget {
  const CooksCardWidget({
    super.key,
    this.image,
    this.time,
    this.name,
    this.rating,
    this.reviews,
    this.distance,
    this.index, required this.cookID,
  });

  final String? image;
  final String? time;
  final String? name;
  final double? rating;
  final int? reviews;
  final String? distance;
  final String cookID;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        Get.toNamed(AppRoutes.cookViewScreen,arguments: cookID);
      },
      paddingVertical: 6.h,
      marginRight: index == null ? 0 : 14.w,
      marginLeft: (index == null) ? 0 : (index == 0 ? 14.w : 0),
      radiusAll: 8.r,
      height: 210.h,
      width: 160.w,
      color: AppColors.bgColor,
      bordersColor: AppColors.borderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 136.h,
            width: double.infinity,
            child: CustomNetworkImage(
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
                // CustomText(
                //     top: 4.h,
                //     textAlign: TextAlign.start,
                //     text: 'Open : ${time ?? ''}',
                //     color: AppColors.primaryColor,
                //     fontSize: 10.sp),
                CustomText(
                  top: 4.h,
                  textAlign: TextAlign.start,
                  maxline: 1,
                  textOverflow: TextOverflow.ellipsis,
                  text: name ?? '',
                  fontSize: 14.sp,
                  bottom: 4.h,
                ),

                // Rating + Distance
                Row(
                  children: [
                    Assets.icons.star.svg(height: 14.h, width: 14.w),
                    Flexible(
                      child: FittedBox(
                        child: CustomText(
                            left: 2.w,
                            text: "${rating ?? 0.0} (${reviews ?? 0})   •",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}