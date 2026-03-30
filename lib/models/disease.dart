class Disease {
  final String id;
  final String name;
  final List<String> symptoms;
  final String advice;

  Disease({
    required this.id,
    required this.name,
    required this.symptoms,
    required this.advice,
  });

  factory Disease.fromJson(Map<String, dynamic> json, String langCode) {
    // Extract translations. Default to English if the specific langCode is missing.
    final translations = json['translations'] as Map<String, dynamic>;
    final localizedData = translations[langCode] ?? translations['en'];

    return Disease(
      id: json['id'],
      name: localizedData['name'],
      symptoms: List<String>.from(localizedData['symptoms']),
      advice: localizedData['advice'],
    );
  }
}