import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/orders/order_controller.dart';
import 'package:meal_deal_app/feature/home/user/card/oder_history_screen.dart';
import 'package:meal_deal_app/feature/home/widgets/cart_section_cook_widget.dart';
import 'package:meal_deal_app/feature/home/widgets/order_history_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../../../widgets/widgets.dart';

class CookOrderDetailsScreen extends StatefulWidget {
  const CookOrderDetailsScreen({super.key});

  @override
  State<CookOrderDetailsScreen> createState() => _CookOrderDetailsScreenState();
}

class _CookOrderDetailsScreenState extends State<CookOrderDetailsScreen> {

  final String orderID = Get.arguments ?? '';

  final OrderController _orderController = Get.find<OrderController>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _orderController.getOrderDetails(orderID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Order History'),
      body: SingleChildScrollView(
        child: GetBuilder<OrderController>(
          builder: (controller) {
            return Column(
              children: [

                /// Cook section
                CartSectionCookWidget(
                  cookName: controller.orderDetailsData?.cook?.cookName ?? 'N/A',
                  cookRating: controller.orderDetailsData?.cook?.rating.toString() ?? '0.0',
                  profileImage: controller.orderDetailsData?.cook?.image ?? '',
                  chatAction: (){},
                ),

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
                      CustomText(
                        fontSize: 12.sp,
                        color: AppColors.black400TextColor,
                        textAlign: TextAlign.start,
                        text: 'Order ID: #${controller.orderDetailsData?.orderNo ?? 'N/A'}',
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
                              ),
                              CustomText(
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
                              ),
                              CustomText(
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
                      // Display cart items
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.orderDetailsData?.carts?.length ?? 0,
                        itemBuilder: (context, index) {
                          final cart = controller.orderDetailsData!.carts![index];
                          return _buildRowTitle(
                            title: '${cart.quantity}x   ${cart.meal?.name ?? 'N/A'}',
                            lastTitle: '\$ ${(cart.totalPrice ?? 0) / 100}',
                            color: AppColors.black600TextColor,
                          );
                        },
                      ),
                      Divider(color: AppColors.borderColor, height: 24.h),

                      // Calculate totals
                      _buildRowTitle(
                        title: 'Subtotal (${controller.orderDetailsData?.carts?.fold<int>(0, (sum, cart) => sum + (cart.quantity ?? 0)) ?? 0} items)',
                        lastTitle: '\$ ${((controller.orderDetailsData?.carts?.fold<int>(0, (sum, cart) => sum + (cart.totalPrice ?? 0)) ?? 0) / 100).toStringAsFixed(2)}',
                        color: AppColors.black600TextColor,
                      ),

                      if (controller.orderDetailsData?.tip != null && controller.orderDetailsData!.tip! > 0)
                        _buildRowTitle(
                          title: 'Tip:',
                          lastTitle: '\$ ${(controller.orderDetailsData!.tip! / 100).toStringAsFixed(2)}',
                          color: AppColors.black600TextColor,
                        ),
                      SizedBox(height: 10.h),
                      _buildRowTitle(
                        title: 'Total:',
                        lastTitle: '\$ ${((controller.orderDetailsData?.totalAmount ?? 0) / 100).toStringAsFixed(2)}',
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 39.h,
                        onPressed: () {},
                        label: 'Accept',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButton(
                        backgroundColor: Colors.transparent,
                        bordersColor: AppColors.black300TextColor,
                        foregroundColor: AppColors.darkColor,
                        height: 39.h,
                        onPressed: () {},
                        label: 'Decline',
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        ),
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
