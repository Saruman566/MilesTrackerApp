import 'package:flutter/material.dart';

class TrackingControls extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;

  const TrackingControls({
    super.key,
    required this.onStart,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = MediaQuery.of(context).size.width * 0.20;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 60, 0, 100),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(onStart, buttonSize),
            const SizedBox(width: 30),
            _buildButton(onStop, buttonSize),
            const SizedBox(width: 25),
            _buildButton(onReset, buttonSize),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(VoidCallback onTap, double size) {
    return Material(
      color: Colors.red.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
        ),
      ),
    );
  }

}
