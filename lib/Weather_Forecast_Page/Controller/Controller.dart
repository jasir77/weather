import 'package:get/get.dart';
import '../../Bottom/Network.dart';
import '../../Models/Models.dart';

class WeatherController extends GetxController {
  RxString location = 'Kochi'.obs;

  // Weather data
  Rx<WeatherAppModel> weatherData = WeatherAppModel().obs;

  // Function to fetch weather data
  Future<void> fetchWeatherData({required String location}) async {
    try {
      final networkHelper = NetworkHelper();
      final data = await networkHelper.getData(location);
      weatherData.value = data;
    } catch (e) {
      print(e.toString());
    }
  }

  // Function to update location
  void updateLocation(String newLocation) {
    location.value = newLocation;
    fetchWeatherData(location: newLocation);
  }
}
