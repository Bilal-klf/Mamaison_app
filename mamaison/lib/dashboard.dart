import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mamaison/api/data_api.dart';
import 'package:mamaison/api/weather_api.dart';
import 'package:mamaison/dashboard_drawer.dart';
import 'package:mamaison/models/data_get.dart';
import 'package:mamaison/widgets/circular_slider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() {
    return _NewDashboard();
  }
}

class _NewDashboard extends State<Dashboard> {
  double _temperature = 0;
  double _humidity = 0;
  double _weatherTemperature = 0;
  double _weatherHumidity = 0;

  @override
  void initState() {
    super.initState();
    _updateUiInfo(); // Fetch temperature and humidity when the widget is first created
  }


  Future<void> _updateUiInfo() async {
    final Map<String, String> queryParameters = {'q': '48.8567,2.3508'};
    final Map<String, String> headers = {
      'X-RapidAPI-Key': WeatherApi.api_key,
      'X-RapidAPI-Host': WeatherApi.api_host
    };

    final Uri uri = Uri.parse(WeatherApi.url).replace(queryParameters: queryParameters);

    try {
      http.Response response =
          await DataGet().sendGetRequest(context, Uri.parse(DataApi.getHouseDataUrl));
      if (response.statusCode == 200) {
        // Parse the response JSON as a List
        List<dynamic> responseData = jsonDecode(response.body);

        // Assuming the temperature is in the first item of the list
        if (responseData.isNotEmpty) {
          int length = responseData.length;
          // Access the temperature from the first item in the list
          double temperature = responseData[length - 1]['temperature'];
          double humidity = responseData[length - 1]['humidity'];
          setState(() {
            _temperature = temperature;
            _humidity = humidity;
          });
          print(temperature);
        } else {
          throw Exception('Empty response data');
        }
      } else {
        throw Exception('Failed to fetch temperature: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch temperature: $e');
    }

    try {
      final http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.isNotEmpty) {
          // Access the temperature from the first item in the list
          double temperatureCelsius = jsonResponse['current']['temp_c'];
          int humidity = jsonResponse['current']['humidity'];
          setState(() {
            _weatherTemperature = temperatureCelsius;
            _weatherHumidity = humidity.toDouble();
          });
          print(_weatherTemperature);
        } else {
          throw Exception('Empty response data');
        }
        // Save the response content into a JSON file
        final String jsonData = json.encode(jsonResponse);
        final String path = 'weather_data.json'; // Change the path as needed

        print(jsonData);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DashboardDrawer(),
      appBar: AppBar(
        title: const Text("Acceuil"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.logout))],
      ),
      body: RefreshIndicator(
        onRefresh: _updateUiInfo,
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Info maison",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircularSlider(
                          progressBarColors: const [
                            Colors.green,
                            Colors.red,
                          ],
                          trackColor: Colors.deepOrangeAccent,
                          shadowColor: Colors.amberAccent,
                          bottomLabelText: 'Temperature',
                          data: _temperature,
                          unity: "°C"),
                      Spacer(),
                      CircularSlider(
                        progressBarColors: [Colors.green, Colors.blue],
                        trackColor: Colors.blueAccent,
                        shadowColor: Colors.lightBlueAccent,
                        bottomLabelText: 'Humidité',
                        data: _humidity,
                        unity: "%",
                      )
                    ]),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Info météo",
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CircularSlider(
                          progressBarColors: const [
                            Colors.green,
                            Colors.red,
                          ],
                          trackColor: Colors.deepOrangeAccent,
                          shadowColor: Colors.amberAccent,
                          bottomLabelText: 'Temperature',
                          data: _weatherTemperature,
                          unity: "°C"),
                      Spacer(),
                      CircularSlider(
                          progressBarColors: [Colors.green, Colors.blue],
                          trackColor: Colors.blueAccent,
                          shadowColor: Colors.lightBlueAccent,
                          bottomLabelText: 'Humidité',
                          data: _weatherHumidity,
                          unity: "%"),
                    ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
