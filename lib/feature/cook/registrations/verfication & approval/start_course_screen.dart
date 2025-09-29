import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';

class StartCourseScreen extends StatefulWidget {
  const StartCourseScreen({super.key});

  @override
  State<StartCourseScreen> createState() => _StartCourseScreenState();
}

class _StartCourseScreenState extends State<StartCourseScreen> {
  // Track completion status
  bool videoCompleted = false;
  bool pdfCompleted = false;
  bool quizzesCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: "",
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Title
            CustomText(
              text: "Short online hygiene course",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
              color: AppColors.darkColor,
            ),

            CustomText(
              text: "(Mandatory)",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.left,
              color: AppColors.darkColor,
            ),

            SizedBox(height: 40.h),

            // Course Options
            _buildCourseOption(
              title: "Video",
              icon: Icons.play_circle_outline,
              isCompleted: videoCompleted,
              onTap: () {
           Get.toNamed(AppRoutes.videoScreen);
              },
            ),

            SizedBox(height: 16.h),

            _buildCourseOption(
              title: "Pdf",
              icon: Icons.picture_as_pdf_outlined,
              isCompleted: pdfCompleted,
              onTap: () {
                Get.toNamed(AppRoutes.pdfScreen);
              },
            ),

            SizedBox(height: 16.h),

            _buildCourseOption(
              title: "Quizzes",
              icon: Icons.quiz_outlined,
              isCompleted: quizzesCompleted,
              onTap: () {
                Get.toNamed(AppRoutes.quizScreen);
              },
            ),

            Spacer(),

            // Optional: Continue button (shown when all completed)
            if (videoCompleted && pdfCompleted && quizzesCompleted)
              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: CustomButton(
                  onPressed: () {
                    // Navigate to next screen
                  },
                  label: "Continue",
                  backgroundColor: Color(0xFFE67E22),
                  foregroundColor: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  radius: 25.r,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseOption({
    required String title,
    required IconData icon,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isCompleted ? Colors.green : Color(0xFFE67E22),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,

              fontWeight: FontWeight.w500,
              color: AppColors.darkColor,
            ),
            Container(
              width: 36.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green.withOpacity(0.1)
                    : Color(0xFFE67E22).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : icon,
                color: isCompleted ? Colors.green : Color(0xFFE67E22),
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}