import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/models/cooks/category_model_data.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/models/cooks/self_contract_model_data.dart';
import 'package:meal_deal_app/models/order/order_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../services/api_client.dart';
import '../../services/api_urls.dart';
import '../../widgets/custom_tost_message.dart';

class OrderController extends GetxController {
  
  /// Get orders
  bool isLoadingOrder = false;
  bool isLoadingOrderMore = false;
  int orderPage = 1;
  int orderTotalPage = -1;
  int orderLimitPage = 10;
  List<OrderModelData> orderData = [];

  Future<void> getOrder(String status,{bool isInitialLoad = true}) async {
    if(isInitialLoad){
      orderData.clear();
      orderPage = 1;
      orderTotalPage = -1;
      isLoadingOrder = true;
      isLoadingOrderMore = false;
      update();
    }

      final response = await ApiClient.getData(ApiUrls.order(status, orderPage,orderLimitPage));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];
        final testData = data.map((json) => OrderModelData.fromJson(json)).toList();
        orderData.addAll(testData);
        orderTotalPage = responseBody['meta']['totalPage'] ?? orderTotalPage;
      }
      isLoadingOrder = false;
      isLoadingOrderMore = false;
      update();
    }


  Future<void> loadMoreOrders(String status) async {
    if(orderPage < orderTotalPage && !isLoadingOrderMore){
      orderPage += 1;
      isLoadingOrderMore = true;
      update();
      await getOrder(status,isInitialLoad: false);

      debugPrint('============> Page++ $orderPage \n=============> totalPage $orderTotalPage');

          }
  }


    /// Get orders
  bool isLoadingOrderHistory = false;
  bool isLoadingOrderHistoryMore = false;
  int orderHistoryPage = 1;
  int orderHistoryTotalPage = -1;
  int orderHistoryLimitPage = 10;
  List<OrderHistoryModelData> orderHistoryData = [];

  Future<void> getOrderHistory({isInitialLoad = true}) async {
    if(isInitialLoad){
      orderHistoryData.clear();
      orderHistoryPage = 1;
      orderHistoryTotalPage = -1;
      isLoadingOrderHistory = true;
      isLoadingOrderHistoryMore = false;
      update();
    }

      final response = await ApiClient.getData(ApiUrls.orderHistory(orderHistoryPage,orderHistoryLimitPage));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];
        final testData = data.map((json) => OrderHistoryModelData.fromJson(json)).toList();
        orderHistoryData.addAll(testData);

       // orderHistoryTotalPage = responseBody['meta']['totalPage'] ?? orderHistoryTotalPage;
      }
    isLoadingOrderHistory = false;
    isLoadingOrderHistoryMore = false;
      update();
    }



  Future<void> loadMoreOrderHistory() async {
    if(orderHistoryPage < orderHistoryTotalPage && !isLoadingOrderHistoryMore){
      orderHistoryPage += 1;
      isLoadingOrderHistoryMore = true;
      update();
      await getOrderHistory(isInitialLoad: false);

      debugPrint('============> Page++ $orderHistoryPage \n=============> totalPage $orderHistoryTotalPage');

          }
  }




  /// Get order Details
  bool isLoadingOrderDetails = false;
  OrderDetailsModelData? orderDetailsData;

  Future<void> getOrderDetails(String orderID) async {
    orderDetailsData = null;
    isLoadingOrderDetails = true;
      update();

      final response = await ApiClient.getData(ApiUrls.orderDetails(orderID));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final  data = responseBody['data'] ?? {};
        orderDetailsData = OrderDetailsModelData.fromJson(data);
      }
    isLoadingOrderDetails = false;
      update();
    }
}