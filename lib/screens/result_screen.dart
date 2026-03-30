import 'package:flutter/material.dart';
import '../models/disease.dart';
import '../services/disease_service.dart';
import '../services/translation_service.dart';
import '../main.dart';
import '../widgets/language_dropdown.dart';

class ResultScreen extends StatefulWidget {
  final List<Disease> matches;
  final DiseaseService service;

  ResultScreen({required this.matches, required this.service});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // Keep localized references if language updates while in resulting screen
  late List<Disease> currentMatches;

  @override
  void initState() {
    super.initState();
    currentMatches = List.from(widget.matches);
    currentLanguageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    currentLanguageNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() async {
    // If the language changes while on this screen, we reload the diseases
    // and attempt to match them based on IDs rather than string names,
    // but a simpler acceptable UX is to navigate the user back to HomeScreen
    // so they start a fresh diagnosis in the correct language.
    // For now, let's just pop back to the Home screen if language changes mid-result.
    if (mounted) {
       Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langCode = currentLanguageNotifier.value;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationService.getText(langCode, 'resultTitle'), 
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
      body: Container(
        color: Colors.grey[50],
        child: currentMatches.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        TranslationService.getText(langCode, 'noMatchTitle'),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        TranslationService.getText(langCode, 'noMatchDesc'),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], height: 1.5),
                      ),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: currentMatches.length,
                itemBuilder: (context, index) {
                  final disease = currentMatches[index];
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.warning_amber_rounded, size: 28, color: Theme.of(context).colorScheme.primary),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  disease.name,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 24, thickness: 1),
                          Text(
                            TranslationService.getText(langCode, 'medicalAdvice'),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            disease.advice,
                            style: TextStyle(height: 1.5, color: Colors.grey[700], fontSize: 15),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info_outline, size: 18, color: Colors.grey[600]),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "${TranslationService.getText(langCode, 'matchedSymptoms')} ${disease.symptoms.join(', ')}",
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600], fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}