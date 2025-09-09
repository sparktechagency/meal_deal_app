import 'package:get/get.dart';
import '../controllers/auth/auth_controller.dart';
import '../feature/bottom_nav_bar/controller/custom_bottom_nav_bar_controller.dart';
class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(CustomBottomNavBarController());
    Get.put(AuthController());

  }}