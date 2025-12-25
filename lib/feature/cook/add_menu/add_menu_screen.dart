import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/simmer_helper.dart';
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

  final ScrollController _scrollController = ScrollController();

  final AddMealController _registrationsController = Get.find<AddMealController>();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
    _registrationsController.getTestSales();
  }

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _addController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _addController.dispose();
    super.dispose();
  }

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
            child: RefreshIndicator(
              onRefresh: () async {
                await _registrationsController.getTestSales();
              },
              child: GetBuilder<AddMealController>(
                  builder: (controller) {
                    if(controller.isLoadingTestSales){
                      return ShimmerHelper.productListSimmer();
                    }

                    // Null safety check করা হয়েছে
                    if(controller.mealData == null ||
                        controller.mealData!.meals == null ||
                        controller.mealData!.meals!.isEmpty){
                      return Center(
                        child: CustomText(text: 'Meal not found yet.'),
                      );
                    }

                    final mealsLength = controller.mealData?.meals?.length ?? 0;

                    return ListView.builder(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: mealsLength + (controller.isLoadingTestSalesMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if(index == mealsLength){
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: const Center(child: CustomLoader()),
                            );
                          }
                          final meals = controller.mealData?.meals;
                          if(meals == null || index >= meals.length) {
                            return const SizedBox.shrink();
                          }
                          final data = meals[index];
                          return MenuCardWidget(
                            imageUrl: data.imageUrls?.firstOrNull ?? '',
                            title: data.mealName ?? 'N/A',
                            subtitle: data.category ?? 'N/A',
                            des: '\$ ${data.pricePerPortion?.toString() ?? '0.00'}',
                          );
                        });
                  }
              ),
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

  void _addScrollListener() {
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _registrationsController.loadMoreTestSales();
        debugPrint("load more true");
      }
    });
  }

}