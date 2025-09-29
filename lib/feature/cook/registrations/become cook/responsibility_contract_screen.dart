import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class ResponsibilityContractScreen extends StatefulWidget {
  const ResponsibilityContractScreen({super.key});

  @override
  State<ResponsibilityContractScreen> createState() =>
      _ResponsibilityContractScreenState();
}

class _ResponsibilityContractScreenState
    extends State<ResponsibilityContractScreen> {
  bool isAgreed = false;

  final List<String> responsibilities = [
    "First, you will need to upload accurate listings for the food items you offer, including clear descriptions, prices, and high-quality images.",
    "It is also your responsibility to comply with health and safety regulations related to food preparation and ensure that all necessary standards are met.",
    "Food should be handled by staff with clean hands and gloves, and proper training should be provided on food safety.",
    "Ensure that the packaging is sealed securely to prevent contamination and spillage.",
    "Delivery staff should wear gloves and masks, and maintain cleanliness to avoid contamination during the delivery process.",
    "Provide clear information about allergens in your food items, so customers with allergies can make informed decisions.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "Self Responsibility Contract",
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
                          value: 0.75,
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
                        text: "Self Responsibility Contract",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.left,
                        color: AppColors.darkColor,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: "Next: Menu Management",
                        fontSize: 14.sp,
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
                    // Introduction Paragraph
                    CustomText(
                      text:
                          'As a seller in a food app, your role involves several key responsibilities to ensure smooth operations and customer satisfaction.By tapping "I AGREE" you assume the responsibility of "Host" and confirm that you have and agree to our "MealDeal" self responsibility.',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                      color: Colors.grey[700],
                      maxline: 6,
                    ),

                    SizedBox(height: 24.h),

                    // Agreement Header
                    CustomText(
                      text: "As Host , you agree and confirm that :",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.left,
                      color: AppColors.darkColor,
                    ),

                    SizedBox(height: 20.h),

                    // Responsibilities List
                    ...responsibilities.asMap().entries.map((entry) {
                      int index = entry.key;
                      String responsibility = entry.value;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Number Circle
                            Container(
                              width: 28.w,
                              height: 28.h,
                              margin: EdgeInsets.only(top: 2.h),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFFE67E22),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: "${index + 1}.",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFE67E22),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Responsibility Text
                            Expanded(
                              child: CustomText(
                                text: responsibility,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.left,
                                color: Colors.grey[700],
                                maxline: 5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),

          // Agreement Button Section
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: CustomButton(
              onPressed: () {
                setState(() {
                  isAgreed = !isAgreed;
                });
                if (isAgreed) {
                  // Handle agreement action
                }
              },
              backgroundColor: Color(0xFFE67E22),
              foregroundColor: Colors.white,
              height: 50.h,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              radius: 8.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Checkbox
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.testSalesScreen);
                    },
                    child: Container(
                      width: 22.w,
                      height: 22.h,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        color: isAgreed ? Colors.white : Colors.transparent,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: isAgreed
                          ? Icon(
                              Icons.check,
                              size: 16.sp,
                              color: Color(0xFFE67E22),
                            )
                          : null,
                    ),
                  ),
                  CustomText(
                    text: "I Agree",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
