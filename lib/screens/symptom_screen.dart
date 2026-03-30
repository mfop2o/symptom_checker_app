import 'package:flutter/material.dart';
import '../services/disease_service.dart';
import '../services/translation_service.dart';
import '../main.dart';
import '../widgets/language_dropdown.dart';
import 'result_screen.dart';

class SymptomScreen extends StatefulWidget {
  @override
  _SymptomScreenState createState() => _SymptomScreenState();
}

class _SymptomScreenState extends State<SymptomScreen> {
  final DiseaseService _service = DiseaseService();
  List<String> availableSymptoms = [];
  List<String> selectedSymptoms = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    // Re-load data when language changes so we get translated symptoms
    currentLanguageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    currentLanguageNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {
      isLoading = true;
      selectedSymptoms.clear(); // clear selections because symptoms change language space
    });
    _loadData();
  }

  Future<void> _loadData() async {
    final langCode = currentLanguageNotifier.value;
    await _service.loadDiseases(langCode);
    
    // Sort symptoms alphabetically so they look nice
    final symptoms = _service.getAllSymptoms();
    symptoms.sort();
    
    setState(() {
      availableSymptoms = symptoms;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final langCode = currentLanguageNotifier.value;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationService.getText(langCode, 'symptomTitle'), 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          LanguageDropdown(
            currentLang: langCode,
            onChanged: (newLang) {
              if (newLang != null) {
                currentLanguageNotifier.value = newLang;
              }
            },
          )
        ],
      ),
      body: isLoading 
        ? Center(child: CircularProgressIndicator())
        : Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TranslationService.getText(langCode, 'symptomQuestion'),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  TranslationService.getText(langCode, 'symptomGuidance'),
                  style: TextStyle(color: Colors.grey[700]),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 12.0,
                      runSpacing: 12.0,
                      children: availableSymptoms.map((symptom) {
                        final isSelected = selectedSymptoms.contains(symptom);
                        return FilterChip(
                          label: Text(symptom.toUpperCase()),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedSymptoms.add(symptom);
                              } else {
                                selectedSymptoms.remove(symptom);
                              }
                            });
                          },
                          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                          labelStyle: TextStyle(
                            color: isSelected 
                                ? Theme.of(context).colorScheme.primary 
                                : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(
                              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[300]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: Icon(Icons.check, color: Colors.white),
        label: Text(
          TranslationService.getText(langCode, 'checkResults'), 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        onPressed: selectedSymptoms.isEmpty ? null : () {
          final matches = _service.getMatchingDiseases(selectedSymptoms);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ResultScreen(matches: matches, service: _service)),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}