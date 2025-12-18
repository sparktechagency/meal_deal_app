import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/auth_controller.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
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
  final CookRegistrationsController _registrationsController =
      Get.find<CookRegistrationsController>();

  @override
  void initState() {
    _registrationsController.getSelfContract();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: "Self Responsibility Contract",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CookRegistrationsController>(
          builder: (controller) {
            if (controller.isLoadingSelf) {
              return Center(child: CustomLoader());
            }
            if (controller.selfContractModelData == null) {
              return CustomText(text: 'self contract not found yet.');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Introduction Paragraph
                CustomText(
                  text: controller.selfContractModelData?.title ?? '',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.left,
                  color: Colors.grey[700],
                  maxline: 6,
                ),

                SizedBox(height: 24.h),

                /// Agreement Header
                CustomText(
                  text:
                      "${controller.selfContractModelData?.noticeLine ?? ''} :",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.left,
                  color: AppColors.darkColor,
                ),

                SizedBox(height: 20.h),

                if (controller.selfContractModelData?.descriptions != null &&
                    controller.selfContractModelData!.descriptions!.isNotEmpty)
                  ...controller.selfContractModelData!.descriptions!.asMap().entries.map((entry) {
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
                                color: AppColors.primaryColor,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "${index + 1}.",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          /// Responsibility Text
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
                  }),

                SizedBox(height: 20.h),
              ],
            );
          },
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:24.w,vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<AuthController>(
                builder: (controller) {
                  return controller.isLoadingTrack ? CustomLoader() : CustomButton(
                    label: 'I Agree',
                      onPressed: ()async{
                      final bool  success = await controller.trackMe(type: 'selfres');

                      if(success){
                        Get.toNamed(AppRoutes.testSalesScreen);
                      }
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
