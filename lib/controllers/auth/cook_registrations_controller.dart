import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/routes/app_routes.dart';

import '../../app/helpers/prefs_helper.dart';
import '../../app/utils/app_constants.dart';
import '../../services/api_client.dart';
import '../../services/api_urls.dart';
import '../../widgets/custom_tost_message.dart';

class CookRegistrationsController extends GetxController {

  /// ===============>>> freelance ==============>>>


  bool isLoadingFreelance = false;
  List<String> freelanceList = [];
  Future<void> freelanceRules() async {
    isLoadingFreelance = true;
    update();
    final response = await ApiClient.getData(
      ApiUrls.freelanceRules,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final data = responseBody['data']['terms'];

      freelanceList = List<String>.from(data.map((json) => json.toString()).toList());

    }
    isLoadingFreelance = false;
    update();
  }


}
