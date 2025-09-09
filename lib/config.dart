import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final List<Map<String, dynamic>> motorcycles = [
    {
      "motorcycle": "Naked / Street",
      "tank": [12, 13, 15, 16, 17, 18],
      "reserve": [2, 3],
      "consumption": [3.5, 4.0, 4.5, 5.0],
    },
    {
      "motorcycle": "Sport Touring",
      "tank": [16, 17, 18, 19, 20],
      "reserve": [3, 4],
      "consumption": [4.5, 5.0, 5.5, 6.0],
    },
    {
      "motorcycle": "Adventure / Touring",
      "tank": [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
      "reserve": [5],
      "consumption": [5.0, 5.5, 6.0, 6.5, 7.0],
    },
    {
      "motorcycle": "Rally / Long-Distance",
      "tank": [30, 31, 32, 33, 34, 35, 36],
      "reserve": [5, 6, 7, 8, 9],
      "consumption": [6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0],
    },
  ];

  Map<String, dynamic>? selectedCategory;
  int? selectedTank;
  int? selectedReserve;
  double? selectedConsumption;

  @override
  void initState() {
    super.initState();
    selectedCategory = motorcycles[0];
    selectedTank = (selectedCategory!["tank"] as List<int>)[0];
    selectedReserve = (selectedCategory!["reserve"] as List<int>)[0];
    selectedConsumption = (selectedCategory!["consumption"] as List<double>)[0];
  }

  Widget buildDropdown<T>({
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String Function(T)? labelBuilder,
  }) {
    return Builder(
      builder: (context) {
        final width = MediaQuery.of(context).size.width * 0.85;
        final height = MediaQuery.of(context).size.height * 0.08;

        return Container(
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              value: value,
              items: items
                  .map((e) => DropdownMenuItem<T>(
                value: e,
                child: Center(
                  child: Text(
                    labelBuilder != null ? labelBuilder(e) : e.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
              ))
                  .toList(),
              onChanged: onChanged,
              isExpanded: true,
              buttonStyleData: ButtonStyleData(
                height: height,
                width: width,
                padding: const EdgeInsets.symmetric(horizontal:  1),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              menuItemStyleData: MenuItemStyleData(
                height: height,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              dropdownStyleData: DropdownStyleData(
                width: width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6),
               offset: const Offset(-15, 0),
              ),
            )
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final boxheight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/config_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(30, 102, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildDropdown<Map<String, dynamic>>(
                  value: selectedCategory,
                  items: motorcycles,
                  onChanged: (newCategory) {
                    setState(() {
                      selectedCategory = newCategory;
                      selectedTank = (newCategory!["tank"] as List<int>)[0];
                      selectedReserve = (newCategory["reserve"] as List<int>)[0];
                      selectedConsumption =
                      (newCategory["consumption"] as List<double>)[0];
                    });
                  },
                  labelBuilder: (cat) => cat["motorcycle"],
                ),
                SizedBox(height: boxheight),
                buildDropdown<int>(
                  value: selectedTank,
                  items: (selectedCategory!["tank"] as List<int>),
                  onChanged: (val) => setState(() => selectedTank = val),
                  labelBuilder: (v) => "$v L",
                ),
                SizedBox(height: boxheight),
                buildDropdown<int>(
                  value: selectedReserve,
                  items: (selectedCategory!["reserve"] as List<int>),
                  onChanged: (val) => setState(() => selectedReserve = val),
                  labelBuilder: (v) => "$v L",
                ),
                SizedBox(height: boxheight),
                buildDropdown<double>(
                  value: selectedConsumption,
                  items: (selectedCategory!["consumption"] as List<double>),
                  onChanged: (val) => setState(() => selectedConsumption = val),
                  labelBuilder: (v) => "$v L/100km",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
