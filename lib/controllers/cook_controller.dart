import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/models/cooks/category_model_data.dart';
import 'package:meal_deal_app/models/cooks/cook_details_model_data.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/models/cooks/self_contract_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../services/api_client.dart';
import '../../services/api_urls.dart';
import '../../widgets/custom_tost_message.dart';

class CookController extends GetxController {

  /// meals details
  CookDetailsModelData? cookDetailsModelData;
  bool isLoadingDetails = false;


  Future<void> getMealDetails(String mealsID) async {
    cookDetailsModelData = null;
    isLoadingDetails = true;
    update();

    final response = await ApiClient.getData(ApiUrls.cookDetails(mealsID));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final  data = responseBody['data'] ?? {};
      cookDetailsModelData = CookDetailsModelData.fromJson(data);

    }
    isLoadingDetails = false;
    update();

  }

}