import 'package:get/get.dart';
import '../controllers/auth/auth_controller.dart';
class DependencyInjection implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());

  }}