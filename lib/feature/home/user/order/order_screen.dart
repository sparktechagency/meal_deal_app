import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_deal_app/app/helpers/helper_data.dart';
import 'package:meal_deal_app/app/utils/app_colors.dart';
import 'package:meal_deal_app/feature/home/user/card/oder_history_screen.dart';
import 'package:meal_deal_app/feature/home/widgets/order_history_widget.dart';
import '../../../../widgets/widgets.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


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
            Expanded(child: SingleChildScrollView(child: OrderHistoryScreen())),

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

  
}



