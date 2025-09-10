import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/utils/app_colors.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

class CategoryBigCardWidget extends StatelessWidget {
  const CategoryBigCardWidget({
    super.key,
    required this.data, required this.index,
  });

  final Map<String, dynamic> data;
  final int  index;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      radiusAll: 8.r,
      height: 187.h,
      width: 166.w,
      color: AppColors.bgColor,
      bordersColor: AppColors.borderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 140.h,
            width: double.infinity,
            child: data['image'],
          ),
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Assets.icons.star.svg(height: 12.h,width: 12.w),
                CustomText(text: data['rating'].toString(),
                  fontSize: 11.sp,
                  right: 8.w,
                  left: 4.w,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  child: CustomText(
                      left: 8.w,
                      text: data['title'],
                      fontSize: 11.sp),
                ),
              ),
              Flexible(
                child: FittedBox(
                  child: CustomText(text: 'Price : ${data['price']}\$',
                      fontSize: 11.sp,
                    right: 8.w,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
