import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/disease.dart';

class DiseaseService {
  List<Disease> _diseases = [];
  List<dynamic> _rawData = [];
  String _currentLang = 'en';

  Future<void> loadDiseases(String langCode) async {
    _currentLang = langCode;
    
    // Only load JSON from disk if we haven't already.
    if (_rawData.isEmpty) {
      final String response = await rootBundle.loadString('lib/data/diseases.json');
      final data = json.decode(response);
      _rawData = data['diseases'] as List;
    }

    // Parse diseases for the currently selected language.
    _diseases = _rawData
        .map((json) => Disease.fromJson(json, _currentLang))
        .toList();
  }
  
  // Expose the raw data to extract all available symptoms across all diseases
  // for the currently selected language, so the UI can build its list dynamically.
  List<String> getAllSymptoms() {
    final Set<String> uniqueSymptoms = {};
    for (var disease in _diseases) {
      uniqueSymptoms.addAll(disease.symptoms);
    }
    return uniqueSymptoms.toList();
  }

  List<Disease> getMatchingDiseases(List<String> selectedSymptoms) {
    return _diseases.where((disease) {
      // Check if ALL selected symptoms are present in the disease
      return selectedSymptoms.every((symptom) => disease.symptoms.contains(symptom));
    }).toList();
  }
}