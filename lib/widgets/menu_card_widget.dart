import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/helpers/time_format.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({
    super.key,  this.title, this.subtitle, this.day, this.dateTime, this.buttonLabel, this.imageUrl, this.onTap, this.des,
  });

  final String? title;
  final String? subtitle;
  final String? des;
  final String? day;
  final String? dateTime;
  final String? buttonLabel;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {},
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 5,
        ),
      ],
      verticalMargin: 6.h,
      horizontalMargin: 6.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            borderRadius: 8.r,
              width: 70.w,
              height: 70.w,
              fit: BoxFit.cover,
              imageUrl: imageUrl ?? ''),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title ?? 'N/A',
                  fontSize: 16.sp,
                ),
                CustomText(
                  text: subtitle ?? "Persons",
                  color: AppColors.black300TextColor,
                  fontSize: 12.sp,
                  top: 2.h,
                ),
                Row(
                  children: [
                    if(day != null && dateTime != null)
                      Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: CustomText(
                              text: TimeFormatHelper.getDayName(day ?? 'N/A'),
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: CustomText(
                              text: TimeFormatHelper.formatDate(DateTime.parse(dateTime ?? 'N/A'))  ?? 'N/A',
                              fontSize: 10.sp,
                              color: AppColors.black300TextColor,
                            ),
                          ),
                        ],
                      ),
                    )else
                      CustomText(text: des ?? ''),
                    if(onTap != null)
                    CustomContainer(
                      onTap: onTap,
                      height: 22.h,
                      width: 60.w,
                      bordersColor: AppColors.primaryColor,
                      radiusAll: 4.r,
                      alignment: Alignment.center,
                      child: CustomText(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          text: buttonLabel ?? 'Details'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
