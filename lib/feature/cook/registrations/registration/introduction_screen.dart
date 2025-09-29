import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Introduction and Explanation",backgroundColor: Colors.transparent,),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20.h,
          children: [
            CustomText(text: "Register With KLZH"),
            CustomText(text: "To operate legally in Zurich, all providers must be registered with the Cantonal Laboratory (KLZH).This process is mandatory.We’ll help you through it:",textAlign: TextAlign.start,),
            buildRow("Fill out the official MD-00029 form digitally."),
            buildRow("We create a PDF and email it to KLZH for you."),
            buildRow("You will receive a business number from KLZH via email within X weeks."),
            buildRow("You must enter this number in the app within 7 days of receiving it."),
            Spacer(),
            CustomButton(onPressed: (){
              Get.toNamed(AppRoutes.digitalFormScreen);
            },label: "I Understand , Continue ",),
            SizedBox(height: 30.h,),

          ],
        ),
      ),
    );
  }

  Widget buildRow(String text) {
    return Row(
            children: [
              Container(
                height: 8.h,
                width: 8.w,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(child: CustomText(text: text,textAlign: TextAlign.start,)),
            ],
          );
  }
}