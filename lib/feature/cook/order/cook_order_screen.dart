import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/helpers/simmer_helper.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/controllers/orders/order_controller.dart';
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

final OrderController _orderController = Get.find<OrderController>();



@override
  void initState() {
    if(_orderController.orderHistoryData.isEmpty){
      _orderController.getOrderHistory();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: 'Order History'),
      body: RefreshIndicator(
        onRefresh: () async {
          await _orderController.getOrderHistory();
        },
        child: GetBuilder<OrderController>(
          builder: (controller) {
            if(controller.isLoadingOrderHistory){
              return ShimmerHelper.productListSimmer();
            }else if(controller.orderHistoryData.isEmpty){
              return Center(child: CustomText(text: 'No order history found'));
            }
            return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: controller.orderHistoryData.length,
              itemBuilder: (context, index) {
                final data = controller.orderHistoryData[index];
                return OrderHistoryWidget(item: data);
              },
            );
          }
        ),
      ),
    );
  }
  
}



