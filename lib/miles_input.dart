import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tracking_controller.dart';

class MilesInput extends StatefulWidget {
  final TrackingController controller;
  final VoidCallback? onMilesChanged;

  const MilesInput({
    Key? key,
    required this.controller,
    this.onMilesChanged,
  }) : super(key: key);

  @override
  State<MilesInput> createState() => _MilesInputState();
}

class _MilesInputState extends State<MilesInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeMiles() {
    String input = _controller.text;
    int? drivenMiles = int.tryParse(input);

    if (drivenMiles != null) {
      widget.controller.driveMiles(drivenMiles);
      _controller.clear();

      if (widget.onMilesChanged != null) {
        widget.onMilesChanged!();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              child: TextField(
                controller: _controller,
                maxLength: 3,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                textAlign: TextAlign.right,
                showCursor: false,
              ),
            ),
            ElevatedButton(
              onPressed: changeMiles,
              child: const Text(
                "Set Miles",
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
