import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weather = WeatherModel();
  final TextEditingController _cityController = TextEditingController();

  bool isLoading = true;
  String cityName = 'Loading...';
  int temperature = 0;
  String description = '';
  int humidity = 0;
  double windSpeed = 0.0;
  int minTemp = 0;
  int maxTemp = 0;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    setState(() => isLoading = true);
    var weatherData = await weather.getLocationWeather();
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      isLoading = false;
      if (weatherData == null) {
        cityName = 'Error/Not Found';
        temperature = 0;
        description = 'N/A';
        return;
      }

      cityName = '${weatherData['name']}, ${weatherData['sys']['country']}';

      double temp = weatherData['main']['temp'];
      temperature = temp.round();

      description = weatherData['weather'][0]['description'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'].toDouble();

      double min = weatherData['main']['temp_min'];
      double max = weatherData['main']['temp_max'];
      minTemp = min.round();
      maxTemp = max.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: SpinKitDoubleBounce(color: Colors.white, size: 80.0),
        )
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FD),
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Weather App',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 25),

                  // Search Bar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            hintText: 'Enter city name...',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                            ),
                          ),
                          onSubmitted: (value) async {
                            if (value.isNotEmpty) {
                              setState(() => isLoading = true);
                              var newWeather = await weather.getCityWeather(value);
                              updateUI(newWeather);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_cityController.text.isNotEmpty) {
                            setState(() => isLoading = true);
                            var newWeather = await weather.getCityWeather(_cityController.text);
                            updateUI(newWeather);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B8BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        ),
                        child: const Text('Search', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Location Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF2B8BFF)),
                      const SizedBox(width: 5),
                      Text(
                        cityName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Main Weather Display
                  const Icon(Icons.cloud, size: 100, color: Color(0xFF2B8BFF)),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$temperature°C',
                    style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87),
                  ),

                  const SizedBox(height: 40),

                  // 2x2 Info Grid
                  Row(
                    children: [
                      _buildInfoCard(Icons.water_drop, 'Humidity', '$humidity%'),
                      _buildInfoCard(Icons.air, 'Wind Speed', '$windSpeed m/s'),
                    ],
                  ),
                  Row(
                    children: [
                      _buildInfoCard(Icons.thermostat, 'Min Temp', '$minTemp°C'),
                      _buildInfoCard(Icons.thermostat, 'Max Temp', '$maxTemp°C'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF2B8BFF), size: 28),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}