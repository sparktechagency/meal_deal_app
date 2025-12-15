import 'package:get/get.dart';
import 'package:meal_deal_app/controllers/auth/cook_registrations_controller.dart';
import 'package:meal_deal_app/controllers/auth/user_controller.dart';
import '../controllers/auth/auth_controller.dart';
import '../feature/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(CustomBottomNavBarController());
    Get.put(AuthController());
    Get.put(CookRegistrationsController());
    Get.put(UserController());

  }}