import 'package:get/get.dart';
import '../modules/home/home_bindings.dart';
import '../modules/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBindings(),
    ),
  ];
}
