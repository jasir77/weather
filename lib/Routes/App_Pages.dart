import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Weather_Forecast_Page/Binding/Binding.dart';
import '../Weather_Page.dart';
import 'App_Routes.dart';

class AppPages {
  static var Lists = [
  GetPage(
  name: AppRoutes.weather,
  page: () => Weather_page(),
  binding:  WeatherBinding(),
  ),
  ];
}