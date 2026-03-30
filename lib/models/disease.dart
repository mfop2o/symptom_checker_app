class Disease {
  final String name;
  final List<String> symptoms;
  final String advice;

  Disease({required this.name, required this.symptoms, required this.advice});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(
      name: json['name'],
      symptoms: List<String>.from(json['symptoms']),
      advice: json['advice'],
    );
  }
}