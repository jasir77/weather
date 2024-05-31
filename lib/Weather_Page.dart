import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Bottom/Bottom.dart';
import 'Weather_Forecast_Page/Controller/Controller.dart';

class Weather_page extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1581608198007-4801faa3859a?q=80&w=1430&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
            ),
          ),
          child: SingleChildScrollView(
            child: Obx(() {
              if (weatherController.weatherData.value.name == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOCATION NOT\n      FOUND',
                        style: TextStyle(
                            color: Colors.teal.shade800,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          weatherController.fetchWeatherData(location:  weatherController.location.value);
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else {
                String? temperature =
                weatherController.weatherData.value.main?.temp != null
                    ? ((weatherController.weatherData.value!.main!.temp! -
                    273)
                    .toStringAsFixed(1))
                    : '';

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor:
                                Colors.transparent.withOpacity(0.5),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      autofocus: true,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        labelStyle:
                                        TextStyle(color: Colors.white),
                                        hintText: 'Search',
                                        hintStyle:
                                        TextStyle(color: Colors.blueGrey),
                                        border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black),
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                      ),
                                      onChanged: (value) => weatherController
                                          .location.value = value,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStatePropertyAll(
                                              Colors.grey),
                                        ),
                                        onPressed: () {
                                          weatherController.fetchWeatherData(location: weatherController.location.value);
                                          Navigator.pop(context); // Close the search dialog
                                        },
                                        child: const Text(
                                          'SELECT',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                      title: const Text(
                        '  Weather App',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(
                        Icons.dashboard,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Text(
                      weatherController.weatherData.value?.name ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 2),
                    Text(
                      ("$temperature ℃"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                          fontWeight: FontWeight.w100),
                    ),
                    Row(
                      children: [
                        double.parse(temperature) <= 2
                            ? const Icon(
                          Icons.cloudy_snowing,
                          color: Colors.white,
                          size: 29,
                        )
                            : double.parse(temperature) >= 15
                            ? const Icon(
                          Icons.sunny,
                          color: Colors.white,
                          size: 29,
                        )
                            : double.parse(temperature) < 15
                            ? const Icon(
                          Icons.wb_cloudy_sharp,
                          color: Colors.white,
                          size: 29,
                        )
                            : const Icon(
                          Icons.sunny,
                          color: Colors.white,
                          size: 29,
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 40),
                        Text(
                          weatherController
                              .weatherData.value?.weather?.isNotEmpty ==
                              true
                              ? weatherController
                              .weatherData.value!.weather![0].main ??
                              ''
                              : '',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 200,
                    ),
                    const Divider(
                      thickness: 2.5,
                      height: 7,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 80),
                    Row(
                      children: [
                        const SizedBox(
                          width: 28,
                        ),
                        BottomInfo(
                          title: 'Wind',
                          temp: weatherController.weatherData.value?.wind?.speed
                              ?.toString() ??
                              '',
                          unit: 'Km/h',
                          color: Colors.orange,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        BottomInfo(
                          temp: weatherController.weatherData.value?.clouds?.all
                              ?.toString() ??
                              '',
                          title: "Clouds",
                          unit: '%',
                          color: Colors.red,
                          width: 4,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        BottomInfo(
                          title: "Humidity",
                          unit: '%',
                          temp: weatherController
                              .weatherData.value?.main?.humidity
                              ?.toString() ??
                              '',
                          color: Colors.green,
                          width: 18,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        BottomInfo(
                          title: 'Feels Like',
                          temp: weatherController
                              .weatherData.value?.main?.feelsLike !=
                              null
                              ? ((weatherController
                              .weatherData.value!.main!.feelsLike! -
                              273)
                              .toStringAsFixed(1))
                              : '',
                          unit: 'C°',
                          color: Colors.blue,
                          width: 10,
                        )
                      ],
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
