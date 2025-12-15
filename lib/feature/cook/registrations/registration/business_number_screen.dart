import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/custom_app_bar.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

class BusinessNumberScreen extends StatefulWidget {
  const BusinessNumberScreen({super.key});

  @override
  State<BusinessNumberScreen> createState() => _BusinessNumberScreenState();
}

class _BusinessNumberScreenState extends State<BusinessNumberScreen> {

  final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Enter Your Business Number",
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16.h),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text:
                  "Please enter the business number you received from KLZH in the mail to complete your registration.",
              textAlign: TextAlign.start,
            ),

            CustomText(text: "Enter Your Business Number"),

            CustomTextField(
              controller: _registrationsController.businessNumberController,
              hintText: "KLZH Business Number",
            ),

            Spacer(),
            GetBuilder<CookRegistrationsController>(
              builder: (controller) {
                return controller.isLoadingBusinessNumber ? CustomLoader() : CustomButton(
                  onPressed: () async{
                  bool  success = await controller.businessNumber();
                  if(success){
                    Navigator.pop(context);
                  }
                  },
                  label: "Submit and Complete Registration",
                );
              }
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
