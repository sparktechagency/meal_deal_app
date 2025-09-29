import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../widgets/widgets.dart';

class OfferCardWidget extends StatelessWidget {
  final Map<String,dynamic> item;

  const OfferCardWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: (){
        Get.toNamed(AppRoutes.productDetailsScreen);
      },
      marginBottom: 12.h,
      paddingAll: 12.w,
      radiusAll: 10.r,
      bordersColor: Colors.grey.shade300,
      color: Colors.white,
      elevation: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: Image.asset(
              item['imageUrl'],
              width: 40.w,
              height: 40.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:
                item['title'],
                  fontWeight: FontWeight.w500, fontSize: 12.sp,
                ),
                CustomText(text:
                item['subtitle'],
                  color: Colors.black54, fontSize: 11.sp,
                ),
                CustomText(
                  top: 4.h,
                  text:
                  "Category : ${item['category']}",
                  color: Colors.black87, fontSize: 11.sp,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14.sp, color: AppColors.primaryColor),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.start,
                        text:
                        item['location'],
                        fontSize: 11.sp, color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          CustomContainer(
            paddingHorizontal: 12.w,
            paddingVertical: 4.h,
            color: Color(0xff3E513E),
            radiusAll: 8.r,
            child: Column(
              children: [
                CustomText(text:
                item['discount'],
                  color: AppColors.primaryColor,
                  fontSize: 12.sp,
                ),
                CustomText(text:
                "With code\nGET20OFF",
                  color: Colors.white, fontSize: 11.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
