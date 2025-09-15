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
    required this.item, required this.index,
  });

  final Map<String, dynamic> item;
  final int  index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: (){
        Get.toNamed(AppRoutes.cookViewScreen);
      },
      paddingVertical: 6.h,
      marginRight: 14.w,
      marginLeft: index == 0 ? 14.w : 0,
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
            child: item['image'],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:  10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  top: 4.h,
                    textAlign: TextAlign.start,
                    text: 'Open : ${item["time"]}',
                    color: AppColors.primaryColor,
                    fontSize: 10.sp),
                CustomText(
                    textAlign: TextAlign.start,
                    maxline: 1,
                    textOverflow: TextOverflow.ellipsis,
                    text: item["name"],
                    fontSize: 14.sp,
                  bottom: 4.h,
                ),

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

              ],
            ),
          ),                    ],
      ),
    );
  }
}
