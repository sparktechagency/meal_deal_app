import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/models/cooks/category_model_data.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/models/cooks/hygiene_course_model_data.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/models/cooks/self_contract_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
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


  /// ===============>>> get Self Contract ==============>>>


  bool isLoadingSelf = false;

  SelfContractModelData? selfContractModelData;
  Future<void> getSelfContract() async {
    isLoadingSelf = true;
    update();
    final response = await ApiClient.getData(
      ApiUrls.contracts,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final data = responseBody['data'];

      selfContractModelData = SelfContractModelData.fromJson(data);
    }
    isLoadingSelf = false;
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








  /// ===============>>> Verification ==============>>>


  final businessController = TextEditingController();

  File? selectedIdDocument;
  File? selectedSelfieOrVideo;
  String idType = 'passport';
  String selfieVideoType = 'selfie';
  bool isLoadingVerification = false;

  static const idOptions = {
    'passport': 'Passport / Resident Permit',
    'nationalId': 'National ID',
  };

  static const selfieOptions = {
    'selfie': 'Selfie',
    'video': 'Video',
  };

  @override
  void onClose() {
    businessController.dispose();
    super.onClose();
  }

  Future<void> captureIdDocument(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        selectedIdDocument = File(pickedFile.path);
        update();
      }
    } catch (e) {
      print('Error picking ID document: $e');
    }
  }

// Selfie/Video capture করার জন্য
  Future<void> captureSelfieOrVideo(ImageSource source, bool isVideo) async {
    try {
      final ImagePicker picker = ImagePicker();

      if (isVideo) {
        final XFile? pickedFile = await picker.pickVideo(source: source);
        if (pickedFile != null) {
          selectedSelfieOrVideo = File(pickedFile.path);
          update();
        }
      } else {
        final XFile? pickedFile = await picker.pickImage(source: source);
        if (pickedFile != null) {
          selectedSelfieOrVideo = File(pickedFile.path);
          update();
        }
      }
    } catch (e) {
      print('Error picking selfie/video: $e');
    }
  }
  Future<void> verification() async {
    if (!_validateForm()) return;

    isLoadingVerification = true;
    update();

    final requestBody = {
      'data': jsonEncode({
        "businessNumber": businessController.text.trim(),
        "validIdType": idType,
        "selfIdType": selfieVideoType,
      }),
    };

    final List<MultipartBody> multipartBodyList = [];

    if (selectedIdDocument != null) {
      multipartBodyList.add(
        MultipartBody('validIdImage', selectedIdDocument!),
      );
    }
    if (selectedSelfieOrVideo != null) {
      multipartBodyList.add(
        MultipartBody('selfieImage', selectedSelfieOrVideo!),
      );
    }


      final response = await ApiClient.postMultipartData(
        ApiUrls.cookVerify,
        requestBody,
        multipartBody: multipartBodyList,
      );

      if (response.statusCode == 200) {
        Get.toNamed(AppRoutes.startCourseScreen);
      } else {
        showToast(response.body['message']);
      }
      isLoadingVerification = false;
      update();

  }

  bool _validateForm() {
    if (selectedIdDocument == null) {
      showToast('Please upload ID document');
      return false;
    }
    return true;
  }





  /// ===============>>> hygiene course  ==============>>>


  bool isLoadingHygiene = false;
  List<HygieneCoursesModelData> hygieneCoursesData = [];
  Future<void> hygieneCourse() async {
    hygieneCoursesData.clear();
    isLoadingHygiene = true;
    update();
    final response = await ApiClient.getData(
      ApiUrls.courses,
    );
    final responseBody = response.body;

    if (response.statusCode == 200) {

      final List data = responseBody['data'] ?? [];

      final hygieneData = data.map((json) => HygieneCoursesModelData.fromJson(json)).toList();

      hygieneCoursesData.addAll(hygieneData);
    }
    isLoadingHygiene = false;
    update();
  }



  /// Add this method in CookRegistrationsController

  bool isLoadingQuiz = false;

  int currentQuestionIndex = 0;
  Map<int, String> userAnswers = {};
  void selectAnswer(String answer) {
    userAnswers[currentQuestionIndex] = answer;
    update();
  }

  void nextQuestion(int totalQuestions) {
    if (currentQuestionIndex < totalQuestions - 1) {
      currentQuestionIndex++;
      update();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      update();
    }
  }

  Future<void> submitQuiz({required List<Map<String, dynamic>> answers, required String quizID,}) async {
    isLoadingQuiz = true;
    update();
      final response = await ApiClient.postData(
        ApiUrls.submitQuizUrl(quizID),
        {
          "answers": answers,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast('Quiz submitted successfully!');
        currentQuestionIndex = 0;
        userAnswers.clear();
        Get.back();
      } else {
        showToast(response.body['message'] ?? 'Failed to submit quiz');
      }
      isLoadingQuiz = false;
      update();
    }


}
