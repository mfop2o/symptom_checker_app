import 'package:flutter/material.dart';
import '../services/disease_service.dart';
import 'result_screen.dart';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final DiseaseService _service = DiseaseService();
  final List<String> symptoms = ["fever", "cough", "fatigue", "chills", "sweating"];
  List<String> selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _service.loadDiseases();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Symptoms")),
      body: ListView(
        children: symptoms.map((symptom) {
          return CheckboxListTile(
            title: Text(symptom),
            value: selectedSymptoms.contains(symptom),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  selectedSymptoms.add(symptom);
                } else {
                  selectedSymptoms.remove(symptom);
                }
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          final matches = _service.getMatchingDiseases(selectedSymptoms);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(matches: matches)),
          );
        },
      ),
    );
  }
}