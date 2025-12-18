import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/add_meal_controller.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/menu_card_widget.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class TestSalesScreen extends StatefulWidget {
  const TestSalesScreen({super.key});

  @override
  State<TestSalesScreen> createState() => _TestSalesScreenState();
}

class _TestSalesScreenState extends State<TestSalesScreen> {


  final AddMealController _registrationsController = Get.find<AddMealController>();

  @override
  void initState() {
    _registrationsController.getTestSales();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: "Test Sales",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Add Dishes",
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.left,
              color: AppColors.darkColor,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: "Help this cook get started",
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.left,
              color: Colors.grey[600],
            ),

            SizedBox(height: 24.h),

            // Dishes List
            GetBuilder<AddMealController>(
              builder: (controller) {
                if(controller.isLoadingTestSales){
                  return CustomLoader();
                }else if(controller.testMealData.isEmpty){
                  return CustomText(text: 'Meal not found yet.');
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.testMealData.length,
                  shrinkWrap: true,
                    itemBuilder: (context,index) {
                      final data = controller.testMealData[index];
                      return MenuCardWidget(
                        imageUrl: data.imageUrls?.first ?? '',
                    title: data.mealName,
                        subtitle: data.category ?? '',
                        des: '\$ ${data.pricePerPortion.toString()}',
                  );
                });
              }
            ),

            SizedBox(height: 24.h),

            /// Add Maximum Three Meal Button
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.addMoreScreen);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: CustomText(
                    text: "Add Maximum Three Meal",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.bgColor,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
            child: CustomButton(
              onPressed: () {
                Get.toNamed(AppRoutes.verificationApprovalScreen);
              },
              label: "Next",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            
            ),
          ),
        ),
      ),
    );
  }
}