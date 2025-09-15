import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class CategoryCardWidget extends StatelessWidget {
  const CategoryCardWidget({
    super.key,
    required this.data, required this.index, this.onTap,
  });

  final Map<String, dynamic> data;
  final int  index;
  final VoidCallback?  onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      marginRight: 14.w,
      marginLeft: index == 0 ? 14.w : 0,
      radiusAll: 8.r,
      height: 100.h,
      width: 75.w,
      color: AppColors.bgColor,
      bordersColor: AppColors.borderColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.h,
            width: double.infinity,
            child: data['image'],
          ),
          FittedBox(child: CustomText(text: data['title'],fontSize: 12.sp,left: 10.w,right: 10.w,top: 6.h,)),
        ],
      ),
    );
  }
}
