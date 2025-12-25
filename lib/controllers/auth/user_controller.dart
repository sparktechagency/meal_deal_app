import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';

import '../../app/helpers/prefs_helper.dart';
import '../../app/utils/app_constants.dart';
import '../../services/api_client.dart';
import '../../services/api_urls.dart';
import '../../widgets/custom_tost_message.dart';

class UserController extends GetxController {

  /// ===============>>> user ==============>>>


  @override
  void onInit() {
    userGet();
    super.onInit();
  }

  bool isLoadingUser = false;
  CookUseModelData? useModelData;
  Future<void> userGet() async {
    isLoadingUser = true;
    update();
    final response = await ApiClient.getData(
      ApiUrls.userMe,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final data = responseBody['data'];

      useModelData = CookUseModelData.fromJson(data);

    }
    isLoadingUser = false;
    update();
  }


}
