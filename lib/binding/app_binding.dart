import 'package:get/get.dart';
import 'package:untitled7/controller/home_controller.dart';

class AppBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}