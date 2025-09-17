import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../widgets/widgets.dart';



class AllCardScreen extends StatefulWidget {
  const AllCardScreen({super.key});

  @override
  State<AllCardScreen> createState() => _AllCardScreenState();
}

class _AllCardScreenState extends State<AllCardScreen> {



  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: const CustomAppBar(
        title: 'All Cart',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            left: 16.w,
            bottom: 10.h,
            text: 'Your items',
            color: AppColors.black800TextColor,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: HelperData.restaurantsCard.length,
              itemBuilder: (context, index) {
                return _menuCardWidget(HelperData.restaurantsCard[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCardWidget(Map<String,dynamic> item) {
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
      horizontalMargin: 16.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(item['image'],height: 44.h,width: 44.w,),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item['name'],
                  fontSize: 16.sp,
                ),
                CustomText(
                  text: "Item : ${item['item']}",
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  top: 2.h,
                ),
              ],
            ),
          ),
          
          CustomButton(
            width:
            80.w,
            height: 28.h,
            fontSize: 10.sp,
            onPressed: (){
              Get.toNamed(AppRoutes.cardScreen);
            },label: 'View Card',)
        ],
      ),
    );
  }
}
