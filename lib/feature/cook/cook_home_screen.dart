import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/helpers/simmer_helper.dart';
import 'package:meal_deal_app/app/helpers/time_format.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/controllers/orders/order_controller.dart';
import 'package:meal_deal_app/custom_assets/assets.gen.dart';
import 'package:meal_deal_app/feature/home/widgets/category_item_widget.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import 'package:meal_deal_app/widgets/label_title_widget.dart';
import 'package:meal_deal_app/widgets/menu_card_widget.dart';
import '../../../app/utils/app_colors.dart';
import '../../../widgets/widgets.dart';

class CookHomeScreen extends StatefulWidget {
  const CookHomeScreen({super.key});

  @override
  State<CookHomeScreen> createState() => _CookHomeScreenState();
}

class _CookHomeScreenState extends State<CookHomeScreen> {

  final OrderController _orderController = Get.find<OrderController>();
  final ScrollController _scrollController = ScrollController();

  String selectedStatus = 'New';

  @override
  void initState() {
    _addScrollListener();
    if (_orderController.orderData.isEmpty) {
      _orderController.getOrder('new');
    }
    super.initState();
  }

  String getBackendStatus(String uiStatus) {
    Map<String, String> statusMapping = {
      'New': 'new',
      'In Preparation': 'in_preparation',
      'Ready for Pickup': 'ready_for_pickup',
      'Completed': 'completed',
      'Cancelled': 'cancelled',
    };
    return statusMapping[uiStatus] ?? 'new';
  }

  void handleStatusChange(String newStatus) {
    setState(() {
      selectedStatus = newStatus;
    });

    String backendStatus = getBackendStatus(newStatus);
    _orderController.getOrder(backendStatus);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      paddingSide: 0,
      appBar: CustomAppBar(
        titleWidget: GetBuilder<UserController>(
            builder: (controller) {
              return CustomListTile(
                imageRadius: 18.r,
                image: controller.useModelData?.profileImage ?? '',
                contentPaddingHorizontal: 16.w,
                titleColor: AppColors.black600TextColor,
                title: 'Welcome!',
                subTitle: controller.useModelData?.name ?? 'N/A',
                subtitleFontSize: 14.sp,
                titleFontSize: 15.sp,
                statusColor: AppColors.black800TextColor,
              );
            }
        ),
        actions: [
          IconButton(onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined,
                color: AppColors.primaryColor,)),
        ],
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CategoryItemWidget(
              selectedValue: selectedStatus,
              categoryItem: HelperData.categoryItemCook,
              showChildCategory: false,
              onStatusChanged: (newStatus) {
                handleStatusChange(newStatus);
              },
            ),
          ),


          GetBuilder<OrderController>(
              builder: (controller) {
                return LabelTitleWidget(
                    isSeeShow: false,
                    title: 'Your Orders ${controller.orderData.length}');
              }
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                String backendStatus = getBackendStatus(selectedStatus);
                await _orderController.getOrder(backendStatus);
              },
              child: GetBuilder<OrderController>(
                  builder: (controller) {
                    if (controller.isLoadingOrder) {
                      return ShimmerHelper.productListSimmer();
                    } else if (controller.orderData.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: 'No Orders Found',
                          fontSize: 16.sp,
                          color: AppColors.black400TextColor,
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      itemCount: controller.orderData.length +
                          (controller.isLoadingOrderMore ? 1 : 0),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == controller.orderData.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Center(child: CustomLoader()),
                          );
                        }
                        return MenuCardWidget(
                          imageUrl: controller.orderData[index].meal?.image ??
                              '',
                          title: controller.orderData[index].meal?.name ??
                              'N/A',
                          subtitle: '\$ ${controller.orderData[index].meal
                              ?.price.toString() ?? '0'}',
                          dateTime: controller.orderData[index].createdAt ?? '',
                          day: controller.orderData[index].createdAt ?? '',
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.cookOrderDetailsScreen,
                              // arguments: {
                              //   'orderId': controller.orderData[index].orderId,
                              // },
                            );
                          },
                        );
                      },
                    );
                  }
              ),
            ),
          ),


        ],
      ),
    );
  }


  void _addScrollListener() {
    _scrollController.addListener((){
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          String backendStatus = getBackendStatus(selectedStatus);
          _orderController.loadMoreOrders(backendStatus);
          debugPrint("load more true");
        }
      },
    );

  }


}
