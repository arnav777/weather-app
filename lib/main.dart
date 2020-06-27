import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherApp(),
    );
  }
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=Bhubaneswar&units=imperial&appid=f8bd41403d5aa5172a2ad781161a47e4");
    var results = jsonDecode(response.body);

    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  // create an init state method to run what is inside it first

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.tealAccent,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 20),
                      child: Text(
                        'Currently in Bhubaneswar',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        temp != null ? temp.toString() + "\u00B0" : "Loading",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        currently != null ? currently.toString() : "Loading",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.brightness_low),
                        title: Text('Temperature'),
                        trailing: Text(temp != null
                            ? temp.toString() + '\u00B0'
                            : "Loading"),
                      ),
                      ListTile(
                        leading: Icon(Icons.cloud),
                        title: Text('Weather'),
                        trailing: Text(description != null
                            ? description.toString()
                            : "Loading"),
                      ),
                      ListTile(
                        leading: Icon(Icons.wb_sunny),
                        title: Text('Humidity'),
                        trailing: Text(
                            humidity != null ? humidity.toString() : "Loading"),
                      ),
                      ListTile(
                        leading: Icon(Icons.power_input),
                        title: Text('Wind Speed'),
                        trailing: Text(windSpeed != null
                            ? windSpeed.toString()
                            : "Loading"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
