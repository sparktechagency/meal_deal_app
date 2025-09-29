import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class TestSalesScreen extends StatefulWidget {
  const TestSalesScreen({super.key});

  @override
  State<TestSalesScreen> createState() => _TestSalesScreenState();
}

class _TestSalesScreenState extends State<TestSalesScreen> {
  // Sample dish data - replace with actual data model
  final List<Map<String, dynamic>> dishes = [
    {
      'name': 'Homemade Chicken Biryani',
      'persons': '3 Persons',
      'price': '\$ 12.52',
      'image': 'assets/images/biryani.jpg', // Replace with actual image
    },
    {
      'name': 'Vegetarian Lasagna',
      'persons': '5 Persons',
      'price': '\$8.90',
      'image': 'assets/images/lasagna.jpg', // Replace with actual image
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Test Sales",
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      SizedBox(
                        width: 45.w,
                        height: 45.h,
                        child: CircularProgressIndicator(
                          value: 0.95,
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFE67E22),
                          ),
                          backgroundColor: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Test Sales (Limited Access)",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.left,
                        color: AppColors.darkColor,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Last Step",
     
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.left,
                        color: Colors.grey[500],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Add Dishes Section
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
                    ...dishes.map((dish) => _buildDishCard(
                      name: dish['name'],
                      persons: dish['persons'],
                      price: dish['price'],
                      imagePath: dish['image'],
                    )).toList(),

                    SizedBox(height: 24.h),

                    // Add Maximum Three Meal Button
                    InkWell(
                      onTap: () {
               Get.toNamed(AppRoutes.addMoreScreen);
                      },
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFE67E22),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: CustomText(
                            text: "Add Maximum Three Meal",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE67E22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Next Button
          Container(
            padding: EdgeInsets.all(20.w),
            color: Colors.white,
            child: CustomButton(
              onPressed: () {
            Get.toNamed(AppRoutes.verificationApprovalScreen);
              },
              label: "Next",
              backgroundColor: Color(0xFFE67E22),
              foregroundColor: Colors.white,
              height: 50.h,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishCard({
    required String name,
    required String persons,
    required String price,
    required String imagePath,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Dish Image
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
              // Uncomment when you have actual images
              // image: DecorationImage(
              //   image: AssetImage(imagePath),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Icon(
              Icons.restaurant,
              size: 30.sp,
              color: Colors.grey[400],
            ),
          ),

          SizedBox(width: 16.w),

          // Dish Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,

                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                  color: AppColors.darkColor,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: persons,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.left,
                  color: Colors.grey[600],
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: price,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                  color: Color(0xFFE67E22),
                ),
              ],
            ),
          ),

          // Edit Button
          CustomButton(
            onPressed: () {
              // Handle edit action
            },
            backgroundColor: Colors.white,
            foregroundColor: AppColors.darkColor,
            bordersColor: Colors.grey[300],
            height: 36.h,
            width: 80.w,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            radius: 8.r,
            prefixIcon: Icons.edit_outlined,
            label: "Edit",
            prefixIconShow: true,
          ),
        ],
      ),
    );
  }
}