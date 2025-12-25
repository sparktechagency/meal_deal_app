import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import 'package:meal_deal_app/models/cooks/category_model_data.dart';
import 'package:meal_deal_app/models/cooks/cook_user_model_data.dart';
import 'package:meal_deal_app/models/cooks/meal_model_data.dart';
import 'package:meal_deal_app/models/cooks/self_contract_model_data.dart';
import 'package:meal_deal_app/routes/app_routes.dart';
import '../../services/api_client.dart';
import '../../services/api_urls.dart';
import '../../widgets/custom_tost_message.dart';

class AddMealController extends GetxController {
  bool isLoadingAddMeal = false;
  bool isLoadingCategory = false;

  List<File>? images;
  List<CategoryModelData> allCategoryData = [];
  Map<String, List<CategoryModelData>> categoryByType = {};

  // Text Controllers
  final TextEditingController mealNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController portionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController fitnessController = TextEditingController();
  final TextEditingController cheatController = TextEditingController();
  final TextEditingController timeOrderController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController warmController = TextEditingController();
  final TextEditingController reheatedController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController pickupMinutesController = TextEditingController();
  final TextEditingController offerController = TextEditingController();
  final TextEditingController finalPriceController = TextEditingController();

  // Dropdown states
  String? selectedCategory;
  String? selectedFitness;
  String? selectedCheat;
  String? selectedWarmOption;
  String? selectedCategoryDietary;

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  /// Fetch categories from API and filter by type
  Future<void> getCategory() async {
    try {
      isLoadingCategory = true;
      update();

      final response = await ApiClient.getData(ApiUrls.category);

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final List data = responseBody['data'] ?? [];

        // Clear previous data
        allCategoryData.clear();
        categoryByType.clear();

        // Parse JSON to model
        final categories = data
            .map((json) => CategoryModelData.fromJson(json))
            .toList();

        allCategoryData.addAll(categories);

        // Filter categories by type
        for (var category in allCategoryData) {
          if (category.type != null) {
            if (!categoryByType.containsKey(category.type)) {
              categoryByType[category.type!] = [];
            }
            categoryByType[category.type]!.add(category);
          }
        }

        print('Categories fetched: ${allCategoryData.length}');
        print('Types: ${categoryByType.keys.toList()}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
    } finally {
      isLoadingCategory = false;
      update();
    }
  }

  /// Get filtered categories by type
  List<CategoryModelData> getFilteredCategories(String type) {
    return categoryByType[type] ?? [];
  }

  /// Get all category types
  List<String> getAllCategoryTypes() {
    return categoryByType.keys.toList();
  }

  /// Get category names by type (for dropdown items)
  List<String> getCategoryNamesByType(String type) {
    return getFilteredCategories(type)
        .map((category) => category.name ?? '')
        .toList();
  }


  /// Update selected category
  void updateSelectedDietary(String? category) {
    selectedCategoryDietary = category;
    update();
  }

  /// Update selected category
  void updateSelectedCategory(String? category) {
    selectedCategory = category;
    update();
  }

  /// Update fitness selection
  void updateSelectedFitness(String? fitness) {
    selectedFitness = fitness;
    update();
  }

  /// Update cheat selection
  void updateSelectedCheat(String? cheat) {
    selectedCheat = cheat;
    update();
  }

  /// Update warm option selection
  void updateSelectedWarmOption(String? option) {
    selectedWarmOption = option;
    update();
  }

  /// Add meal function
  Future<void> becomeCook() async {
    try {
      isLoadingAddMeal = true;
      update();

      final requestBody = {
        'data': jsonEncode({
          "mealName": mealNameController.text,
          "description": descriptionController.text,
          "cuisineName": "american",
          "availablePortion": int.tryParse(portionController.text) ?? 0,
          "dietaryCategories": selectedCategoryDietary ?? "",
          "category": selectedCategory ?? "",
          "fitnessFlow": selectedFitness ?? "",
          "cheatFlow": selectedCheat ?? "",
          "timeForOrder": timeOrderController.text,
          "timeForPickUpFood": pickUpTimeController.text,
          "pricePerPortion": double.tryParse(priceController.text) ?? 0.0,
          "servedWarm": selectedWarmOption ?? "",
          "coldReheatPrice": double.tryParse(reheatedController.text) ?? 0.0,
          "ingredients": ingredientsController.text.split(','),
          "allergyInformation": allergyController.text,
          "price": double.tryParse(priceController.text) ?? 0.0,
          "location": locationController.text,
          "pickUpTime": pickupMinutesController.text,
          "offer": offerController.text
        }),
      };

      final List<MultipartBody> multipartBodyList = [];

      if (images != null && images!.isNotEmpty) {
        for (int i = 0; i < images!.length; i++) {
          multipartBodyList.add(MultipartBody('images', images![i]));
        }
      }

      final response = await ApiClient.postMultipartData(
        ApiUrls.addMeal,
        requestBody,
        multipartBody: multipartBodyList,
      );

      if (response.statusCode == 200) {
        getTestSales();
        Get.back();
        clearControllers();
      }
    } catch (e) {
      print('Error adding meal: $e');
    } finally {
      isLoadingAddMeal = false;
      update();
    }
  }

  /// Get test meals
  bool isLoadingTestSales = false;
  bool isLoadingTestSalesMore = false;
  int testMealPage = 1;
  int testMealLimitPage = 10;
  int testMealTotalPage = -1;
  MealModelData? mealData;

  Future<void> getTestSales({bool isInitialLoad = true}) async {
    if (isInitialLoad) {
      mealData = null;
      testMealPage = 1;
      testMealTotalPage = -1;
      isLoadingTestSales = true;
      isLoadingTestSalesMore = false;
      update();
    }
      final response = await ApiClient.getData(ApiUrls.mealTest(testMealPage, testMealLimitPage));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final  data = responseBody['data'] ?? {};

        mealData = MealModelData.fromJson(data);
        testMealTotalPage = responseBody['meta']['totalPage'] ?? -1;


      }
      isLoadingTestSales = false;
      isLoadingTestSalesMore = false;
      update();

  }

  Future<void> loadMoreTestSales() async {
    if (testMealPage < testMealTotalPage && !isLoadingTestSalesMore) {
      testMealPage += 1;
      isLoadingTestSalesMore = true;
      update();
      await getTestSales(isInitialLoad: false);

      debugPrint(
          '============> Page++ $testMealPage \n=============> totalPage $testMealTotalPage');
    }
  }

  void clearControllers() {
    mealNameController.clear();
    descriptionController.clear();
    portionController.clear();
    categoryController.clear();
    fitnessController.clear();
    cheatController.clear();
    timeOrderController.clear();
    pickUpTimeController.clear();
    priceController.clear();
    warmController.clear();
    reheatedController.clear();
    ingredientsController.clear();
    allergyController.clear();
    locationController.clear();
    pickupMinutesController.clear();
    offerController.clear();
    finalPriceController.clear();
    images = null;
    selectedCategory = null;
    selectedFitness = null;
    selectedCheat = null;
    selectedWarmOption = null;
    selectedCategoryDietary = null;
    update();
  }

  @override
  void onClose() {
    mealNameController.dispose();
    descriptionController.dispose();
    portionController.dispose();
    categoryController.dispose();
    fitnessController.dispose();
    cheatController.dispose();
    timeOrderController.dispose();
    pickUpTimeController.dispose();
    priceController.dispose();
    warmController.dispose();
    reheatedController.dispose();
    ingredientsController.dispose();
    allergyController.dispose();
    locationController.dispose();
    pickupMinutesController.dispose();
    offerController.dispose();
    finalPriceController.dispose();
    images = null;
    selectedCategory = null;
    selectedFitness = null;
    selectedCheat = null;
    selectedWarmOption = null;
    selectedCategoryDietary = null;
    super.onClose();
  }
}