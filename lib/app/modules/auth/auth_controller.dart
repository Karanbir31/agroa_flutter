import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  void login() {
    // Basic navigation to Home after "login"
    Get.offAllNamed(Routes.HOME);
  }
}
