import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {

  Map<String, dynamic> motorcycleSmall = {
    "motorcycle": "Naked / Street",
    "tank": [12, 13, 15, 16, 17, 18],
    "reserve": [2, 3],
    "consumption": [3.5, 4, 4.5, 5],
  };

  Map<String, dynamic> motorcycleMiddle = {
    "motorcycle": "Sport Touring",
    "tank": [16, 17, 18, 19, 20],
    "reserve": [3, 4],
    "consumption": [4.5, 5, 5.5, 6],
  };

  Map<String, dynamic> motorcycleBig = {
    "motorcycle": "Adventure / Touring",
    "tank": [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
    "reserve": [5],
    "consumption": [5, 5.5, 6, 6.5, 7],
  };

  Map<String, dynamic> motorcycleBiggest = {
    "motorcycle": "Rally / Long-Distance",
    "tank": [30, 31, 32, 33, 34, 35, 36],
    "reserve": [5, 6, 7, 8, 9],
    "consumption": [6, 6.5, 7, 7.5, 8, 8.5, 9],
  };

  Map<String, dynamic>? loadedData;

  @override
  void initState() {
    super.initState();
    loadData('myMotorcycle');
  }

  Future<void> saveData(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString(key, jsonString);
    print("Data saved for $key");
  }

  Future<void> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      setState(() {
        loadedData = jsonDecode(jsonString);
      });
      print("Data loaded for $key");
      print("Tank options: ${loadedData!['tank']}");
      print("Consumption options: ${loadedData!['consumption']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motorcycle Config")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select a motorcycle to save/load"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => saveData('myMotorcycle', motorcycleSmall),
              child: const Text("Save Small Motorcycle"),
            ),
            ElevatedButton(
              onPressed: () => saveData('myMotorcycle', motorcycleMiddle),
              child: const Text("Save Middle Motorcycle"),
            ),
            ElevatedButton(
              onPressed: () => saveData('myMotorcycle', motorcycleBig),
              child: const Text("Save Big Motorcycle"),
            ),
            ElevatedButton(
              onPressed: () => saveData('myMotorcycle', motorcycleBiggest),
              child: const Text("Save Biggest Motorcycle"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => loadData('myMotorcycle'),
              child: const Text("Load Motorcycle Data"),
            ),
            if (loadedData != null) ...[
              const SizedBox(height: 20),
              Text("Loaded motorcycle: ${loadedData!['motorcycle']}"),
              Text("Tank options: ${loadedData!['tank']}"),
              Text("Reserve options: ${loadedData!['reserve']}"),
              Text("Consumption options: ${loadedData!['consumption']}"),
            ],
          ],
        ),
      ),
    );
  }
}
