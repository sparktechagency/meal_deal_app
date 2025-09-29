import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';  // Assuming you're using custom widgets

import 'package:meal_deal_app/app/utils/app_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: CustomText(
          text: "Quiz",
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.darkColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz Description
              CustomText(
                text: "Lorem ipsum dolor sit amet consectetur. Neque blandit faucibus neque quam. Condimentum et feugiat bibendum feugiat consequat sagittis fames volutpat nisl.",
                fontSize: 14.sp,
                color: Colors.grey[800],
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 16.h),

              // Question Options
              _buildOption("A", "Lorem ipsum dolor sit amet consectetur."),
              _buildOption("B", "Lorem ipsum dolor sit amet consectetur."),
              _buildOption("C", "Lorem ipsum dolor sit amet consectetur."),
              _buildOption("D", "Lorem ipsum dolor sit amet consectetur."),

              SizedBox(height: 100.h),

              // Submit Button
              CustomButton(
                onPressed: () {
                 Get.toNamed(AppRoutes.waitingApprovalScreen);
                },
                label: "Submit",

              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String option, String text) {
    return RadioListTile<String>(
      title: CustomText(
        text: "$option. $text",
        fontSize: 14.sp,
        color: Colors.grey[800],
        textAlign: TextAlign.start,
      ),
      value: option,
      groupValue: selectedAnswer,
      onChanged: (value) {
        setState(() {
          selectedAnswer = value;
        });
      },
      activeColor: AppColors.primaryColor,
    );
  }
}
