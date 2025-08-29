import 'package:flutter/material.dart';

class MilesInput extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
      FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 150,
                child: TextField(
                  maxLength: 3,
                  style: TextStyle(
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 20),
                  ),
                  textAlign: TextAlign.right,
                  showCursor: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 2),
              ElevatedButton(
                onPressed: null,
                child: const Text("Set Miles",style: TextStyle(
                  color: Colors.transparent,
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
