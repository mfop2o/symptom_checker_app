class TranslationService {
  static const Map<String, Map<String, String>> staticTexts = {
    // English
    'en': {
      'appTitle': 'Ethio Health',
      'homeHeader': 'Welcome',
      'homeWelcome': 'Welcome to Ethio Health Symptom Checker',
      'disclaimer': 'Please note: This app provides general guidance based on common illnesses in Ethiopia. It does not replace professional medical advice.',
      'startCheck': 'Start Symptom Check',
      
      'symptomTitle': 'Select Symptoms',
      'symptomQuestion': 'What are you experiencing?',
      'symptomGuidance': 'Select all the symptoms that apply to you.',
      'checkResults': 'Check Results',
      
      'resultTitle': 'Assessment Results',
      'noMatchTitle': 'No specific match found.',
      'noMatchDesc': 'Your symptom combination didn\'t directly match our database of common illnesses. Please consult a healthcare professional for an accurate diagnosis.',
      'medicalAdvice': 'Medical Advice:',
      'matchedSymptoms': 'Matched Symptoms in database:',
    },
    
    // Amharic
    'am': {
      'appTitle': 'ኢትዮ ጤና',
      'homeHeader': 'እንኳን ደህና መጡ',
      'homeWelcome': 'ወደ ኢትዮ ጤና የምልክት መመርመሪያ እንኳን ደህና መጡ',
      'disclaimer': 'እባክዎ ልብ ይበሉ፡ ይህ መተግበሪያ በኢትዮጵያ ውስጥ በተለመዱት በሽታዎች ላይ ተመስርቶ አጠቃላይ መመሪያን ይሰጣል። የህክምና ባለሙያን ምክር አይተካም።',
      'startCheck': 'ምርመራ ጀምር',
      
      'symptomTitle': 'ምልክቶችን ይምረጡ',
      'symptomQuestion': 'ምን እየተሰማዎት ነው?',
      'symptomGuidance': 'የሚሰማዎትን ምልክቶች በሙሉ ይምረጡ።',
      'checkResults': 'ውጤት ተመልከት',
      
      'resultTitle': 'የምርመራ ውጤቶች',
      'noMatchTitle': 'ምንም በሽታ አልተገኘም።',
      'noMatchDesc': 'የመረጧቸው ምልክቶች ከመረጃ ቋታችን ውስጥ ካሉት የተለመዱ በሽታዎች ጋር አይጣጣሙም። እባክዎ ለትክክለኛ ምርመራ የህክምና ባለሙያ ያማክሩ።',
      'medicalAdvice': 'የህክምና ምክር፡',
      'matchedSymptoms': 'የተገኙ ምልክቶች መረጃ፡',
    },
    
    // Afaan Oromoo
    'or': {
      'appTitle': 'Fayyaa Itiyoo',
      'homeHeader': 'Baga Nagaan Dhuftan',
      'homeWelcome': 'Madaallii Mallattoo Dhukkubaa Fayyaa Itiyootti Baga Nagaan Dhuftan',
      'disclaimer': 'Hubadhaa: Appilikeeshiniin kun dhukkuboota yeroo baayyee Itiyoophiyaa keessatti mullatan irratti hundaa\'uun qajeelfama waliigalaa kenna. Yaala ogeessa fayyaa iddoo hin bu\'u.',
      'startCheck': 'Madaallii Eegali',
      
      'symptomTitle': 'Mallattoolee Filadhaa',
      'symptomQuestion': 'Maaltu sitti dhagahamaa jira?',
      'symptomGuidance': 'Mallattoolee sitti dhagahaman hunda filadhu.',
      'checkResults': 'Bu\'aa Ilaali',
      
      'resultTitle': 'Bu\'aa Madaallii',
      'noMatchTitle': 'Dhukkubni wal-fakkaatu hin argamne.',
      'noMatchDesc': 'Mallattooleen ati filatte dhukkuboota kuusaa keenya keessa jiran waliin kallattiin wal hin fakkaatu. Maaloo qorannoo sirrii argachuuf ogeessa fayyaa mariisisi.',
      'medicalAdvice': 'Gorsa Fayyaa:',
      'matchedSymptoms': 'Mallattoolee wal-fakkaatan kuusaa keessatti:',
    }
  };

  static String getText(String langCode, String key) {
    return staticTexts[langCode]?[key] ?? staticTexts['en']?[key] ?? key;
  }
}
