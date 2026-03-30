import 'package:flutter/material.dart';
import 'symptom_screen.dart';
import '../main.dart';
import '../services/translation_service.dart';
import '../widgets/language_dropdown.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langCode = currentLanguageNotifier.value;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationService.getText(langCode, 'appTitle'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
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
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.05),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.health_and_safety,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 24),
              Text(
                TranslationService.getText(langCode, 'homeHeader'),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                TranslationService.getText(langCode, 'homeWelcome'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ]
                ),
                child: Text(
                  TranslationService.getText(langCode, 'disclaimer'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SymptomScreen()),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_rounded, color: Colors.white),
                  label: Text(
                    TranslationService.getText(langCode, 'startCheck'),
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}