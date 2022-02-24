import 'package:get/get.dart';
import 'package:newsapp/feature/splash/controller/splash.controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
