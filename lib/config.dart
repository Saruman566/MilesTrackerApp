import 'package:flutter/material.dart';
import 'tracking_controller.dart';

class ConfigPage extends StatefulWidget {
  final TrackingController? controller;
  const ConfigPage({Key? key, this.controller}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final List<String> titles = ["Litre", "Litre", "Litre/100km"];
  final List<Map<String, dynamic>> motorcycles = [
    {
      "category": "Naked / Street",
    },
    {
      "category": "Sport Touring",
    },
    {
      "category": "Adventure / Touring",
    },
    {
      "category": "Rally / Long-Distance",
    },
  ];

  Map<String, dynamic>? selectedCategory;
  double? selectedTank;
  double? selectedReserve;
  double? selectedConsumption;
  double resultMaxMiles = 0.0;

  late TextEditingController tankController;
  late TextEditingController reserveController;
  late TextEditingController consumptionController;

  @override
  void initState() {
    super.initState();
    tankController = TextEditingController(text: 0.toString());
    reserveController = TextEditingController(text: 0.toString());
    consumptionController = TextEditingController(
      text: 0.toString(),
    );
  }

  void changeKmToMiles(double resultMaxKilometer) {
    double miles = resultMaxKilometer * 0.621371;
    int roundedMiles = (miles).round();

    widget.controller?.milesBeforeRefuel = roundedMiles;
    Navigator.pop(context, roundedMiles);
  }

  void mileCalculation() {
    final tank = double.tryParse(tankController.text) ?? 0.0;
    final reserve = double.tryParse(reserveController.text) ?? 0.0;
    final consumption = double.tryParse(consumptionController.text) ?? 0.0;

    resultMaxMiles = (tank - reserve) / (consumption / 100);
    changeKmToMiles(resultMaxMiles);
  }


  void getBack() {
    Navigator.pop(context);
  }

  Widget buildDropdownCategory() {
    return DropdownButton<Map<String, dynamic>>(
      value: selectedCategory,
      items: motorcycles
          .map(
            (e) => DropdownMenuItem<Map<String, dynamic>>(
              value: e,
              child: Text(
                e["motorcycle"],
                style: const TextStyle(fontSize: 25, color: Colors.blueAccent),
              ),
            ),
          )
          .toList(),
      onChanged: (newCategory) {
        setState(() {
          selectedCategory = newCategory;

          tankController.text = selectedTank.toString();
          reserveController.text = selectedReserve.toString();
          consumptionController.text = selectedConsumption.toString();
        });
      },
      isExpanded: true,
    );
  }

  Widget buildNumberInputField(
    TextEditingController controller,
    String label,
    double inputHeight,
    double inputWidth,
  ) {
    return SizedBox(
      height: inputHeight,
      width: inputWidth,
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: const TextStyle(fontSize: 40, color: Colors.blueAccent),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 30, color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black, width: 0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.lightBlueAccent,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.black,
        ),
      ),
    );
  }

  Widget buildInputRow(
      TextEditingController tankController,
      double inputHeight,
      double inputWidth,
      double inputBoxheight,
      double inputBoxWidth,
      ) {
    return Row(
      children: [
        buildNumberInputField(
          tankController,
          "",
          inputHeight,
          inputWidth,
        ),
        SizedBox(
          height: inputBoxheight,
          width: inputBoxWidth,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                "Litre",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget calculationButtons(BuildContext context) {
    final boxheight4 = MediaQuery.of(context).size.height * 0.06;
    return Container(
      padding:  const EdgeInsets.fromLTRB(0, 0, 28, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: mileCalculation,
            child: const Text(
              "Give me max Miles",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: boxheight4 - 30),
          ElevatedButton(
            onPressed: getBack,
            child: const Text(
              "Get Back",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    // placeholder
    final boxheight = MediaQuery.of(context).size.height * 0.194;
    final boxheight1 = MediaQuery.of(context).size.height * 0.103;
    final boxheight2 = MediaQuery.of(context).size.height * 0.103;
    final boxheight3 = MediaQuery.of(context).size.height * 0.05;
    // text-field
    final inputBoxWidth = MediaQuery.of(context).size.width * 0.45;
    final inputBoxheight = MediaQuery.of(context).size.height * 0.08;
    // input-field
    final inputWidth = MediaQuery.of(context).size.width * 0.4;
    final inputHeight = MediaQuery.of(context).size.height * 0.09;

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
                SizedBox(height: boxheight),
                buildInputRow(tankController, inputHeight, inputWidth, inputBoxheight, inputBoxWidth),
                SizedBox(height: boxheight1),
                buildInputRow(reserveController, inputHeight, inputWidth, inputBoxheight, inputBoxWidth),
                SizedBox(height: boxheight2),
                buildInputRow(consumptionController, inputHeight, inputWidth, inputBoxheight, inputBoxWidth),
                SizedBox(height: boxheight3),
                calculationButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
