import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../widgets/widgets.dart';
import '../../widgets/cart_section_cook_widget.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Order Info
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
                  CustomContainer(
                    paddingHorizontal: 6.r,
                    paddingVertical: 2.r,
                    color: Colors.red.withOpacity(0.1),
                    radiusAll: 10.r,
                    child: CustomText(
                      fontSize: 12.sp,
                      text: 'Preparing',
                    ),
                  ),
                ],
              ),
              CustomText(
                bottom: 10.h,
                top: 10.h,
                fontSize: 18.sp,
                textAlign: TextAlign.start,
                text: 'MealDeal is preparing your food',
              ),

              /// Timeline widget
              _buildOrderTimeline(),
            ],
          ),
        ),

        /// Cook section
        CartSectionCookWidget(chatAction: () {
          Get.toNamed(AppRoutes.chatInboxScreen);
        }),

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
      ],
    );
  }

  /// Reusable Timeline
  Widget _buildOrderTimeline() {
    final steps = [
      {"title": "Order Placed", "time": "12:00", "done": true},
      {"title": "In Preparation", "time": "12:30", "done": true},
      {"title": "Ready for Pick Up", "time": "13:00", "done": false},
      {"title": "Picked Up", "time": "13:30", "done": false},
    ];

    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        indicatorTheme: IndicatorThemeData(size: 20.r),
        connectorTheme: ConnectorThemeData(thickness: 2.r),
      ),
      builder: TimelineTileBuilder.connected(
        itemCount: steps.length,
        contentsBuilder: (context, index) {
          final step = steps[index];
          return Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: step["title"].toString(),
                  fontSize: 14.sp,
                  color: step["done"] == true
                      ? AppColors.primaryColor
                      : AppColors.black400TextColor,
                ),
                CustomText(
                  text: step["time"].toString(),
                  fontSize: 12.sp,
                  color: AppColors.black400TextColor,
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (context, index) {
          final done = steps[index]["done"] as bool;
          return Indicator.dot(
            size: 20.r,
            color: done ? AppColors.primaryColor : Colors.grey,
          );
        },
        connectorBuilder: (context, index, type) {
          final done = steps[index]["done"] as bool;
          return SolidLineConnector(
            color: done ? AppColors.primaryColor : Colors.grey,
          );
        },
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
