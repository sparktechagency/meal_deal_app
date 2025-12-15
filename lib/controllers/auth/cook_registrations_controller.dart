import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
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



  /// ===============>>> freelance ==============>>>


  bool isLoadingPdf = false;
  String pdf = '';
  Future<void> getPdf() async {
    isLoadingPdf = true;
    update();
    final response = await ApiClient.getData(
      ApiUrls.compliance,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final data = responseBody['data']['documentUrl'];

      pdf = data;
    }
    isLoadingPdf = false;
    update();
  }




  /// ===============>>> freelance ==============>>>


  bool isLoadingBusinessNumber = false;
  final TextEditingController businessNumberController = TextEditingController();
  Future<bool> businessNumber() async {
    isLoadingBusinessNumber = true;
    update();

    final requestBody = {
      "businessNumber": businessNumberController.text.trim(),
    };
    bool isSuccess = false;
    final response = await ApiClient.postData(
      ApiUrls.businessNumber,requestBody,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      final data = responseBody['data']['user'];

      Get.find<UserController>().cookUseModelData = CookUseModelData.fromJson(data);

      Get.find<UserController>().refresh();

      debugPrint('+++++++++++++>>>>> ${Get.find<UserController>().cookUseModelData?.isKlzhRegistered}');

      showToast('Thank you. Your registration with the health authorities is now complete and verified.');
      //Get.toNamed(AppRoutes.registrationCompletedScreen);

      isSuccess = true;
    }
    isLoadingBusinessNumber = false;
    update();

    return isSuccess;
  }





  /// ===============>>> become a cook ==============>>>


  bool isLoadingBecome = false;
  File? profileImage;
  List<File>? kitchenImages;
  File? certificates;
  final TextEditingController desController = TextEditingController();
  final TextEditingController sortDesController = TextEditingController();
  final TextEditingController locationController = TextEditingController();


  Future<void> becomeCook() async {
    isLoadingBecome = true;
    update();

    final requestBody = {
      'data' : jsonEncode({
        "description": desController.text.trim(),
        "shortDescription": sortDesController.text.trim(),
        "location": locationController.text.trim(),
      }),
    };

    final List<MultipartBody> multipartBodyList = [];

    if (profileImage != null) {
      multipartBodyList.add(
        MultipartBody('profileImage', profileImage!),
      );
    }
    if (kitchenImages != null && kitchenImages!.isNotEmpty) {
      for (int i = 0; i < kitchenImages!.length; i++) {
        multipartBodyList.add(
          MultipartBody('kitchenImages', kitchenImages![i]),
        );
      }
    }
    if (certificates != null) {
      multipartBodyList.add(
        MultipartBody('certificates', certificates!),
      );
    }
    final response = await ApiClient.postMultipartData(
      ApiUrls.become,requestBody, multipartBody: multipartBodyList,
    );
    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.responsibilityContractScreen);
    }
    isLoadingBecome = false;
    update();

  }


}
