import 'package:flutter/material.dart';
import 'symptom_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ምልክቶችን ይምረጡ")),
      body: Center(
        child: ElevatedButton(
          child: Text("Start Symptom Check"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SymptomScreen()),
            );
          },
        ),
      ),
    );
  }
}