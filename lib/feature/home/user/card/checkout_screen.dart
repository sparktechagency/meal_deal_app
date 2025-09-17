import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../widgets/widgets.dart';
import '../../widgets/cart_section_cook_widget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),

          CartSectionCookWidget(),

          SizedBox(height: 10.h),

          CustomText(
            color: AppColors.black400TextColor,
            textAlign: TextAlign.start,
            text: 'Address :\n4140 Parker Rd. Allentown, New Mexico 31134',
          ),

          SizedBox(height: 16.h),
          CustomButton(
            height: 38.h,
            fontSize: 14.sp,
            onPressed: () {},
            label: 'Edit Address',
          ),

          Divider(color: AppColors.borderColor, height: 44.h),

          _buildRowTitle(title: 'Your oder', lastTitle: 'Edit oder',onTap: () => Navigator.pop(context)),

          SizedBox(height: 10.h),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => _buildRowTitle(
              title: '2x   Swiss Pastries',
              lastTitle: '\$ 12.43',
              color: AppColors.black600TextColor,
            ),
          ),
          SizedBox(height: 10.h),

          Divider(color: AppColors.borderColor, height: 24.h),

          _buildRowTitle(title: 'Add promotion', lastTitle: 'Add',onTap: (){
            showModalBottomSheet(
              backgroundColor: Colors.white,
                context: context, builder: (context) {
              return _buildPomoCodeBottomSheet();
            });
          }),
          Divider(color: AppColors.borderColor, height: 24.h),

          _buildRowTitle(title: 'Tip your MealDeal', lastTitle: 'Choose'),
        ],
      ),

      bottomNavigationBar: CustomContainer(
        paddingAll: 16.r,
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRowTitle(title: 'Subtotal (4 items)', lastTitle: '\$ 12.43', color: AppColors.black600TextColor),
              _buildRowTitle(title: 'Service fee:', lastTitle: '\$ 1.43', color: AppColors.black600TextColor),
              _buildRowTitle(title: 'Delivery fee:', lastTitle: '\$ 5.00', color: AppColors.black600TextColor),
              _buildRowTitle(title: 'Tip to your Cook:', lastTitle: '\$ 2.00', color: AppColors.black600TextColor),



              SizedBox(height: 16.h),
              CustomContainer(
                onTap: (){
                  Get.toNamed(AppRoutes.oderHistoryScreen);
                },
                paddingAll: 14.r,
                color: AppColors.primaryColor,
                radiusAll: 8.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomText(
                        text: 'Pay Now',
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                    Flexible(
                      child: CustomText(
                        text: '\$ ${15.00}',
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildRowTitle({
    VoidCallback? onTap,
    required String title,
    required String lastTitle,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: CustomText(
            color: color ?? AppColors.black400TextColor,
            textAlign: TextAlign.start,
            text: title,
          ),
        ),

        Flexible(
          child: GestureDetector(
            onTap: onTap,
            child: CustomText(
              color: color ?? AppColors.primaryColor,
              textAlign: TextAlign.start,
              text: lastTitle,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPomoCodeBottomSheet() {
    return CustomContainer(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 6.h),
          SizedBox(
              width: 50.w,
              child: Divider(
                  color: AppColors.grayShade100,
                  thickness: 6.h)),
          CustomText(
              top: 10.h,
              bottom: 10.h,
              text: 'Choose promotion for your order',fontSize: 16.sp),

          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomContainer(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                  verticalMargin: 6.h,
                  horizontalMargin: 16.w,
                  paddingAll: 10.w,
                  color: Colors.white,
                  radiusAll: 12.r,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Assets.icons.pomoCode.svg(),
                    title: CustomText(
                        textAlign: TextAlign.start,
                        text: 'Promotion 15% for Loteria'),
                    subtitle: CustomText(
                      textAlign: TextAlign.start,
                      text: 'Expried on :    11 May 2021',fontSize: 12.sp,color: AppColors.colorA0A0A0,),
                  ),
                );
              },),
          )
        ],
      ),
    );
  }

}
