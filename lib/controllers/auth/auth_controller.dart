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

class AuthController extends GetxController {
  /// <======================= register ===========================>
  bool isLoadingRegister = false;
  bool isChecked = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String role = '';

  void onChanged(value) {
    isChecked = !isChecked;
    update();
  }

  void cleanFieldRegister() {
    usernameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPassController.clear();
  }

  Future<void> register(String role) async {
    isLoadingRegister = true;
    update();

    final requestBody = {
      'name': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'phoneNumber': phoneController.text.trim(),
      'password': confirmPassController.text,
      'role': role,
    };
    // print(requestBody);
    final response = await ApiClient.postData(
      ApiUrls.register,
      requestBody,
      headers: {'Content-Type': 'application/json'},
    );

    final responseBody = response.body;
    if (response.statusCode == 200) {
      await PrefsHelper.setString(AppConstants.bearerToken, responseBody['data']?['token'] ?? '');
      await PrefsHelper.setString(AppConstants.email, requestBody['email'] ?? '');
      Get.toNamed(AppRoutes.otpScreen);
      cleanFieldRegister();
    } else {
      showToast(responseBody['message']);
    }
    isLoadingRegister = false;
    update();
  }

  /// <======================= verifyOTP ===========================>
  bool isLoadingOtp = false;
  final TextEditingController otpController = TextEditingController();

  Future<bool> verifyOTP() async {
    isLoadingOtp = true;
    update();

    bool success = false;
    String email = await PrefsHelper.getString(AppConstants.email);
    final requestBody = {'email': email, 'otp': otpController.text.trim()};

    final response = await ApiClient.postData(ApiUrls.verifyOtp, requestBody);
    final responseBody = response.body;

    if (response.statusCode == 200) {
      role = responseBody['data']?['role'] ?? '';
      await PrefsHelper.setString(AppConstants.bearerToken, responseBody['data']?['accessToken'] ?? '',
      );
      success = true;

      otpController.clear();
    } else {
      showToast(responseBody['message']);
    }

    isLoadingOtp = false;
    update();
    return success;
  }

  /// <======================= login ===========================>
  bool isLoadingLogin = false;
  final TextEditingController loginEmailController = TextEditingController(
    text: kDebugMode ? 'ikramulhasantanvir@gmail.com' : '',
  );
  final TextEditingController loginPasswordController = TextEditingController(
    text: kDebugMode ? '1qazxsw2' : '',
  );

  CookUseModelData? cookUseModelData;

  void cleanFieldLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  Future<void> login() async {
    isLoadingLogin = true;
    update();

    final requestBody = {
      'email': loginEmailController.text.trim(),
      'password': loginPasswordController.text,
    };

    final response = await ApiClient.postData(ApiUrls.login, requestBody);
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final data = responseBody['data'];

      cookUseModelData = CookUseModelData.fromJson(data);

      await PrefsHelper.setString(AppConstants.bearerToken, responseBody['data']?['accessToken'] ?? '');
      await PrefsHelper.setString(AppConstants.role, responseBody['data']?['role'] ?? '',);


      if(cookUseModelData?.user?.isVerified == false){
        Get.toNamed(AppRoutes.otpScreen);
        return;
      }

      if (responseBody['data']?['role'] == 'user') {
        Get.offAllNamed(AppRoutes.userBottomNavBar);
      } else {
        if(cookUseModelData?.user?.trackStep == 0){
          Get.toNamed(AppRoutes.agreementScreen);
        }else if(cookUseModelData?.user?.trackStep == 1){
          Get.toNamed(AppRoutes.officialRegistration);
        }
        else{
          Get.offAllNamed(AppRoutes.cookBottomNavBar);
        }
      }
      // Get.offAllNamed(AppRoutes.agreementScreen);
      // cleanFieldLogin();
    } else {
      // if (responseBody['message'] == "We've sent an OTP to your email to verify your profile.") {
      //   Get.toNamed(AppRoutes.otpScreen);
      // }
      // showToast(responseBody['message']);
    }

    isLoadingLogin = false;
    update();
  }

  /// <======================= forgot ===========================>
  bool isLoadingForgot = false;
  final TextEditingController forgotEmailController = TextEditingController();

  void cleanFieldForgot() {
    forgotEmailController.clear();
  }

  Future<void> forgot() async {
    isLoadingForgot = true;
    update();

    final requestBody = {'contact': forgotEmailController.text.trim()};

    final response = await ApiClient.postData(
      ApiUrls.forgetPassword,
      requestBody,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.otpScreen, arguments: 'forgot');
      showToast(responseBody['message']);
      cleanFieldForgot();
    } else {
      showToast(responseBody['message']);
    }

    isLoadingForgot = false;
    update();
  }

  /// <======================= reset Password ===========================>
  bool isLoadingReset = false;
  final TextEditingController resetPasswordController = TextEditingController();
  final TextEditingController newResetPasswordController =
      TextEditingController();

  void cleanFieldReset() async {
    resetPasswordController.clear();
    newResetPasswordController.clear();
    await PrefsHelper.remove(AppConstants.bearerToken);
    await PrefsHelper.remove(AppConstants.role);
  }

  Future<void> resetPassword() async {
    isLoadingReset = true;
    update();
    final requestBody = {'newPassword': newResetPasswordController.text};

    final response = await ApiClient.postData(
      ApiUrls.resetPassword,
      requestBody,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {
      // Get.offAllNamed(AppRoutes.loginScreen);
      Get.offAllNamed(AppRoutes.roleScreen);
      showToast(responseBody['message']);
      cleanFieldReset();
    } else {
      showToast(responseBody['message']);
    }

    isLoadingReset = false;
    update();
  }



  /// <======================= track me ===========================>
  bool isLoadingTrack = false;


  Future<bool> trackMe() async {
    isLoadingTrack = true;
    update();

    bool isSuccess = false;

    final response = await ApiClient.patch(
      ApiUrls.trackMe,{},
    );
    if (response.statusCode == 200) {
      isSuccess = true;
      update();
    } else {
    }
    isLoadingTrack = false;
    update();

    return isSuccess;
  }





  /// <======================= Log out related work are here ===========================>
  void logOut() async {
    await PrefsHelper.remove(AppConstants.bearerToken);
    await PrefsHelper.remove(AppConstants.role);
    Get.offAllNamed(AppRoutes.roleScreen);
  }

  /// <======================= dispose all controllers ===========================>
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    phoneController.dispose();
    otpController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    forgotEmailController.dispose();
    resetPasswordController.dispose();
    newResetPasswordController.dispose();
    super.onClose();
  }
}
