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
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 135, 0, 0),
      child: Container(
        color: Colors.transparent,
        width: 900,
        height: 92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: IconButton(
                  icon: Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                    width: 100,
                    height: 100,
                  ),),
                  onPressed: onStart,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.5),
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                child: IconButton(
                  icon: Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ),),
                  onPressed: onStart,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.5),
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: IconButton(
                  icon: Opacity(
                    opacity: 0.0,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ),),
                  onPressed: onStart,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.5),
                    padding: EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}