import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/disease.dart';

class DiseaseService {
  List<Disease> _diseases = [];

  Future<void> loadDiseases() async {
    final String response = await rootBundle.loadString('lib/data/diseases.json');
    final data = json.decode(response);
    _diseases = (data['diseases'] as List)
        .map((json) => Disease.fromJson(json))
        .toList();
  }

  List<Disease> getMatchingDiseases(List<String> selectedSymptoms) {
    return _diseases.where((disease) {
      return selectedSymptoms.every((symptom) => disease.symptoms.contains(symptom));
    }).toList();
  }
}