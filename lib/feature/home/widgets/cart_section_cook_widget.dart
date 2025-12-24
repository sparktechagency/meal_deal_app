import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../app/utils/app_colors.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../widgets/widgets.dart';

class CartSectionCookWidget extends StatelessWidget {
  const CartSectionCookWidget({
    super.key, this.chatAction, this.radiusAll, this.cookName, this.cookRating, this.profileImage,
  });

  final VoidCallback? chatAction;
  final double? radiusAll;
  final String? cookName;
  final String? cookRating;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        Get.toNamed(AppRoutes.cookViewScreen);
      },
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 5,
        ),
      ],
      verticalMargin: 10.h,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: radiusAll ?? 12.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            borderRadius: radiusAll ?? 12.r,
              imageUrl: profileImage ?? '',height: 60.h,width: 60.w),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: cookName ?? "N/A",
                  fontSize: 16.sp,
                ),
                Row(
                  children: [
                    Assets.icons.star.svg(height: 14.w, width: 14.w),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: CustomText(
                        text: cookRating ?? '0.0',
                        fontSize: 12.sp,
                        color: AppColors.colorA0A0A0,
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
          if(chatAction != null)
          CustomContainer(
          onTap: chatAction,
            color: Colors.black.withOpacity(0.05),
            paddingAll: 8.r,
              shape: BoxShape.circle,
              child: Assets.icons.chat.svg()),
        ],
      ),
    );
  }
}
