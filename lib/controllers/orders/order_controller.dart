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
  List<OrderModelData> orderData = [];

  Future<void> getOrder(String status) async {
    orderData.clear();
      isLoadingOrder = true;
      update();

      final response = await ApiClient.getData(ApiUrls.order(status));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];
        final testData = data.map((json) => OrderModelData.fromJson(json)).toList();
        orderData.addAll(testData);
      }
      isLoadingOrder = false;
      update();
    }


    /// Get orders
  bool isLoadingOrderHistory = false;
  List<OrderHistoryModelData> orderHistoryData = [];

  Future<void> getOrderHistory() async {
    orderHistoryData.clear();
    isLoadingOrderHistory = true;
      update();

      final response = await ApiClient.getData(ApiUrls.orderHistory);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];
        final testData = data.map((json) => OrderHistoryModelData.fromJson(json)).toList();
        orderHistoryData.addAll(testData);
      }
    isLoadingOrderHistory = false;
      update();
    }
}