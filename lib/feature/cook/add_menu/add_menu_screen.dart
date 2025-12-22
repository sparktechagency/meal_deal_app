import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/menu_card_widget.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class AddMenuScreen extends StatefulWidget {
  const AddMenuScreen({super.key});

  @override
  State<AddMenuScreen> createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {

  final AddMealController _registrationsController = Get.find<AddMealController>();

  @override
  void initState() {
    _registrationsController.getTestSales();
    super.initState();
  }

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
            child: GetBuilder<AddMealController>(
                builder: (controller) {
                  if(controller.isLoadingTestSales){
                    return CustomLoader();
                  }else if(controller.testMealData.isEmpty){
                    return CustomText(text: 'Meal not found yet.');
                  }
                  return ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.testMealData.length,
                      itemBuilder: (context,index) {
                        final data = controller.testMealData[index];
                        return MenuCardWidget(
                          imageUrl: data.imageUrls?.firstOrNull?.toString() ?? '',                          title: data.mealName ?? 'N/A',
                          subtitle: data.category ?? '',
                          des: '\$ ${data.pricePerPortion.toString()}',
                        );
                      });
                }
            ),
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

}
