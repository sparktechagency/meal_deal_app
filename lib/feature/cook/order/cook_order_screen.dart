import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/user/card/oder_history_screen.dart';
import 'package:meal_deal_app/feature/home/widgets/cart_section_cook_widget.dart';
import 'package:meal_deal_app/feature/home/widgets/order_history_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../widgets/widgets.dart';

class CookOrderScreen extends StatefulWidget {
  const CookOrderScreen({super.key});

  @override
  State<CookOrderScreen> createState() => _CookOrderScreenState();
}

class _CookOrderScreenState extends State<CookOrderScreen> {


  String selectedValue = 'current Order’s';


  final buttons = [
    {'label' : 'Current Order’s', 'value' : 'current Order’s'},
    {'label' : 'History', 'value' : 'history'},
  ];


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Order History'),
      body: Column(
        children: [
          SizedBox(height: 12.h),
          TwoButtonWidget(
              selectedBgColor: AppColors.primaryColor,
              buttons: buttons, selectedValue: selectedValue, onTap: (value){
            selectedValue = value;
            setState(() {});
          }),


          SizedBox(height: 20.h),
          if(selectedValue == 'current Order’s')
            Expanded(child: SingleChildScrollView(child: Column(
              children: [
                /// Order Info

                /// Cook section
                CartSectionCookWidget(chatAction: () {
                  Get.toNamed(AppRoutes.chatInboxScreen);
                }),


                CustomContainer(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                  verticalMargin: 10.h,
                  paddingAll: 16.w,
                  color: Colors.white,
                  radiusAll: 12.r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Order Id + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            fontSize: 12.sp,
                            color: AppColors.black400TextColor,
                            textAlign: TextAlign.start,
                            text: 'Order #23241232',
                          ),
                          CustomText(
                            fontSize: 12.sp,
                            text: '5 Mins to Accept Order',
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                color: AppColors.black400TextColor,
                                textAlign: TextAlign.start,
                                text: 'Picked Up',
                              ), CustomText(
                                textAlign: TextAlign.start,
                                text: '1 PM - 1.30 PM',
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                color: AppColors.black400TextColor,
                                textAlign: TextAlign.start,
                                text: 'Ready to Serve',
                              ), CustomText(
                                textAlign: TextAlign.start,
                                text: '3 Persons',
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),


                /// Order detail section
                CustomContainer(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                  verticalMargin: 10.h,
                  paddingAll: 10.w,
                  color: Colors.white,
                  radiusAll: 12.r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        bottom: 10.h,
                        color: AppColors.black400TextColor,
                        textAlign: TextAlign.start,
                        text: 'Order detail',
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) => _buildRowTitle(
                          title: '2x   Swiss Pastries',
                          lastTitle: '\$ 12.43',
                          color: AppColors.black600TextColor,
                        ),
                      ),
                      Divider(color: AppColors.borderColor, height: 24.h),
                      _buildRowTitle(
                        title: 'Subtotal (4 items)',
                        lastTitle: '\$ 12.43',
                        color: AppColors.black600TextColor,
                      ),
                      _buildRowTitle(
                        title: 'Service fee:',
                        lastTitle: '\$ 1.43',
                        color: AppColors.black600TextColor,
                      ),
                      _buildRowTitle(
                        title: 'Delivery fee:',
                        lastTitle: '\$ 5.00',
                        color: AppColors.black600TextColor,
                      ),
                      SizedBox(height: 10.h),
                      _buildRowTitle(
                        title: 'Total:',
                        lastTitle: '\$ 7.50',
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 32.h),
                Row(children: [
                  Expanded(child: CustomButton(
                    height: 39.h,
                    onPressed: (){},label: 'Accept',)),
                  SizedBox(width: 16.w),
                  Expanded(child: CustomButton(
                    backgroundColor: Colors.transparent,
                    bordersColor:  AppColors.black300TextColor,
                    foregroundColor: AppColors.darkColor,
                    height: 39.h,
                    onPressed: (){},label: 'Decline',)),
                ],)
              ],
            )
            )),

          if(selectedValue == 'history')
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: HelperData.recentOrders.length,
                itemBuilder: (context, index) {
                  final data = HelperData.recentOrders[index];
                  return OrderHistoryWidget(item: data);
                },
              ),
            ),

        ],
      ),
    );
  }


  /// Reusable row title widget
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
              color: color ?? AppColors.black400TextColor,
              textAlign: TextAlign.start,
              text: lastTitle,
            ),
          ),
        ),
      ],
    );
  }
  
}



