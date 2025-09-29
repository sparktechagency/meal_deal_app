import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../controllers/auth/auth_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_text.dart';

class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Hygiene Compliance",backgroundColor: Colors.transparent,),
body: Container(
  child: SfPdfViewer.network(
      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf')),
      
      bottomNavigationBar: Padding(padding: EdgeInsetsGeometry.all(16.h),
      
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8.r))
        ),

        child:         Row(
          children: [
            GetBuilder<AuthController>(
                builder: (controller) {

                  return Checkbox(
                    value: controller.isChecked,
                    onChanged: (value) {
                      controller.onChanged(value);
                      Get.toNamed(AppRoutes.completedScreen);
                    },
                    activeColor: AppColors.secondaryColor,
                    side: BorderSide(color: Colors.white),
                  );
                }
            ),
            Expanded(
              child: CustomText(
                text: "I have read and understood the official hygiene guideline.",
                fontSize: 11.sp,maxline: 2,
                textAlign: TextAlign.start,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),)
    );
  }
}