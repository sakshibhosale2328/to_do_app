import 'package:get/get.dart';
import 'package:untitled7/binding/app_binding.dart';
import 'package:untitled7/pages/homescreen.dart';
import 'package:untitled7/routs/routs.dart';

class AppPages
{
  static String INITIAL_ROUTE =AppRoutes.HOME_SCREEN_ROUTE;
  static final Pages =[
    GetPage(
        name: AppRoutes.HOME_SCREEN_ROUTE,
        page: ()=>HomeScreen(),
      binding: AppBinding()
    )
  ];
}