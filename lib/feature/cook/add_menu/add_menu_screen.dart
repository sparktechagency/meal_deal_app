import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Menu Management'),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: CustomText(text: 'Category', fontSize: 16.sp),
              ),
              TextButton(
                onPressed: () {
                  showDialog(context: context, builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: CustomText(text: 'Add New Category'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                            hintText: 'e.g., Vegan',
                            controller: _addController),
                      ],
                    ),
                    actions: [
                      Row(children: [
                        Expanded(child: CustomButton(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.primaryColor,
                          bordersColor: AppColors.primaryColor,
                          fontSize: 14.sp,
                          height: 38.h,
                          onPressed: (){
                            Get.back();
                          },label: 'Cancel',)),
                        SizedBox(width: 10.w),
                        Expanded(child: CustomButton(
                          fontSize: 14.sp,
                          height: 38.h,
                          onPressed: (){
                            Get.back();
                          },label: 'Save New',)),
                      ],),

                    ],
                  ));
                },
                child: CustomText(
                  text: 'Create Category',
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),

          CustomTextField(
            prefixIcon: Icon(Icons.search, color: AppColors.appGreyColor),
            hintText: 'What would you like to order today?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AppColors.black500TextColor),
            ),
            validator: (_) => null,
            controller: _searchController,
          ),


          Expanded(
            child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return _menuCardWidget();
                }),
          ),



          CustomButton(
              prefixIcon: Icons.add_circle,
              onPressed: (){
                Get.toNamed(AppRoutes.addMoreScreen);
              },label: 'Add More Menu'),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }


  Widget _menuCardWidget() {
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
      //horizontalMargin: 16.w,
      paddingAll: 10.w,
      color: Colors.white,
      radiusAll: 12.r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.img.image(
            width: 70.w,
            height: 70.w,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Homemade Chicken Biryani',
                  fontSize: 16.sp,
                ),
                CustomText(
                  text: "3 Persons",
                  color: AppColors.black300TextColor,
                  fontSize: 12.sp,
                  top: 2.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: CustomText(
                              text: "Today",
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: CustomText(
                              text: "4PM-5PM",
                              fontSize: 10.sp,
                              color: AppColors.black300TextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomContainer(
                      height: 22.h,
                      width: 60.w,
                      bordersColor: AppColors.primaryColor,
                      radiusAll: 4.r,
                      alignment: Alignment.center,
                      child: CustomText(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          text: 'Edit'),
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
