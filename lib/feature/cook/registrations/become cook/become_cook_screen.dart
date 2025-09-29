import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class BecomeCookScreen extends StatefulWidget {
  const BecomeCookScreen({super.key});

  @override
  State<BecomeCookScreen> createState() => _BecomeCookScreenState();
}

class _BecomeCookScreenState extends State<BecomeCookScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(
        title: "Become a Cook",
        backgroundColor: Colors.transparent,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Progress Indicator Section
              _buildProgressSection(),

              SizedBox(height: 30.h),

              // Tell Us Section
              CustomText(
                text: "Tell Us Something About Yourself.",
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,

              ),

              SizedBox(height: 12.h),

              CustomText(
                text: "Every Cook gets their own page, and your name is will know you and search for you. You can change it at any time.",

                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left,
                color: AppColors.black04TextColor,
         
              ),

              SizedBox(height: 30.h),

              // Description Section
              CustomText(
                text: "Short Description About Your Cook",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,

              ),

              SizedBox(height: 12.h),

              // Description TextField
              CustomTextField(
                controller: _descriptionController,
                hintText: "I cook home made Moroccan food with love....",
                maxLines: 4,
                minLines: 4,
                contentPaddingHorizontal: 16.w,
                contentPaddingVertical: 12.h,
                maxLength: 80,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filColor: Colors.white,
              ),
              

              SizedBox(height: 10.h),

              // My Location Section
              _buildSectionCard(
                title: "My Location",
                child: _buildLocationItem(
                  icon: Icons.home,
                  title: "Home Cook Address",
                  subtitle: "Add Your Pickup Address",
                  onTap: () {
                    // Handle address selection
                  },
                ),
              ),

              SizedBox(height: 20.h),

              // Verification Section
              _buildSectionCard(
                title: "Verification and Certification",
                child: _buildLocationItem(
                  icon: Icons.home,
                  title: "Cooking Certificate",
                  subtitle: "If you have cooking certificate Add this.",
                  onTap: () {
                Get.toNamed(AppRoutes.verificationCertificationScreen);
                  },
                ),
              ),

              SizedBox(height: 40.h),

              // Next Button
              CustomButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.availabilityScreen);
                },
                label: "Next",

              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: EdgeInsets.all(8.h),
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(8.r))
),
      height: 70.h,
      width: double.infinity,
      child: Row(
      children: [
        Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Introduction",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
                color: AppColors.darkColor,
              ),
              SizedBox(height: 4.h),
              CustomText(
                text: "Next: Your Availability",
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.left,
                color: Colors.grey[500],
              ),
            ],
          ),
        ),
      ],
    ),);
  }

  Widget _buildSectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
                color: AppColors.darkColor,
              ),
              Icon(
                Icons.edit_outlined,
                size: 20.sp,
                color: Colors.grey[600],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildLocationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: Color(0xFFE67E22),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.left,
                    color: AppColors.darkColor,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: subtitle,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.left,
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}