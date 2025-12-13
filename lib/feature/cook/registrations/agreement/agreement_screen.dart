import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/simmer_helper.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/custom_app_bar.dart';
import 'package:meal_deal_app/widgets/widgets.dart';

import '../../../../controllers/auth/auth_controller.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {

  final CookRegistrationsController _registrationsController = Get.find<CookRegistrationsController>();
  @override
  void initState() {
    _registrationsController.freelanceRules();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Freelance Agreement",backgroundColor: Colors.transparent,),
      body:SingleChildScrollView(
        child: Padding(padding: EdgeInsetsGeometry.all(16.r),
        child: Column(
          spacing: 15.h,
          children: [
          Align(alignment:Alignment.center,child:   CustomText(text: "Responsibility & Freelancer Agreement",textAlign: TextAlign.center,),),
            CustomText(text: "This contract makes it clear that:",textAlign: TextAlign.center,),

            GetBuilder<CookRegistrationsController>(
              builder: (controller) {
                if (controller.isLoadingFreelance) {
                  return ShimmerHelper.freelanceListShimmer();
                }

                if (controller.freelanceList.isEmpty) {
                  return Center(child: Text('No rules found'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  itemCount: controller.freelanceList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: '${index + 1}. '),
                          Expanded(
                            child: CustomText(
                              textAlign: TextAlign.left,
                                text: controller.freelanceList[index]),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Row(
              children: [
                GetBuilder<AuthController>(
                    builder: (controller) {
                      return Checkbox(
                        value: controller.isChecked,
                        onChanged: (value) => controller.onChanged(value),
                        activeColor: AppColors.primaryColor,
                      );
                    }
                ),
                Expanded(
                  child: CustomText(
                    text: "I have read and understood the official Freelancing Agreement.",
                    fontSize: 11.sp,maxline: 2,
                    textAlign: TextAlign.start,
                    // color: AppColors.textColor4D4D4D,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            CustomButton(onPressed: (){
              if(Get.find<AuthController>().isChecked == false){
                showToast('Please accept the Agreement');
                return;
              }
              Get.toNamed(AppRoutes.confrimScreen);
            },label: "Continue Freelancing Agreement",fontSize: 16.sp,)
          ],
        ),),
      )
    );
  }
}