import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/widgets/custom_button.dart';
import 'package:meal_deal_app/widgets/custom_loader.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../controllers/auth/auth_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../../widgets/custom_text.dart';

class ComplianceScreen extends StatefulWidget {
  const ComplianceScreen({super.key});

  @override
  State<ComplianceScreen> createState() => _ComplianceScreenState();
}

class _ComplianceScreenState extends State<ComplianceScreen> {


  final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();


  @override
  void initState() {
    _registrationsController.getPdf();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Hygiene Compliance",
      ),
      body: GetBuilder<CookRegistrationsController>(
        builder: (controller) {
          if(controller.isLoadingPdf){
            return Center(child: CustomLoader());
          }else if(controller.pdf.isEmpty){
            return CustomText(text: 'Hygiene Compliance not found yet.');
          }
          return Container(
            color: AppColors.bgColor,
            child:  SfPdfViewer.network(
              controller.pdf,
            ),
          );
        }
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        color: AppColors.bgColor,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text:
                "I have read and understood the official hygiene guideline.",
                fontSize: 11.sp,
                textAlign: TextAlign.start,
                color: Colors.black,
                bottom: 10.h,
                top: 10.h,
              ),

              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingTrack ? CustomLoader() : CustomButton(onPressed: ()async{

                    final bool success = await controller.trackMe(type: 'hygiene');


                    if(success){
                      Get.offAllNamed(AppRoutes.becomeCookScreen);
                    }

                  },label: 'Next');
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
