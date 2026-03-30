import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  final String currentLang;
  final ValueChanged<String?> onChanged;

  const LanguageDropdown({
    Key? key,
    required this.currentLang,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLang,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: Theme.of(context).colorScheme.primary,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onChanged: onChanged,
          items: const [
            DropdownMenuItem(
              value: 'en',
              child: Text("English"),
            ),
            DropdownMenuItem(
              value: 'am',
              child: Text("አማርኛ"),
            ),
            DropdownMenuItem(
              value: 'or',
              child: Text("Afaan Oromoo"),
            ),
          ],
        ),
      ),
    );
  }
}
