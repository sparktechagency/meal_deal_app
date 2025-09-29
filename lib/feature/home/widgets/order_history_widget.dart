import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class OrderHistoryWidget extends StatelessWidget {
  final Map<String,dynamic> item;

  const OrderHistoryWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.asset(item['image'],width: 46.w,height: 46.h,),
      ) ,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'Completed',fontSize: 12.sp,color: Color(0xff16BD16),),
          CustomText(text: item["title"]),
        ],
      ),
      subtitle: CustomText(
          textAlign: TextAlign.start,
          text: '2 items',fontSize: 10.sp,color: AppColors.black300TextColor),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(text: item['date'],color: AppColors.black300TextColor,fontSize: 10.sp),
          CustomText(text: item['price']),
        ],
      ),
    );
  }
}
