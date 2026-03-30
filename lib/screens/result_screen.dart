import 'package:flutter/material.dart';
import '../models/disease.dart';

class ResultScreen extends StatelessWidget {
  final List<Disease> matches;

  ResultScreen({required this.matches});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: matches.isEmpty
          ? Center(child: Text("No matching diseases found."))
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final disease = matches[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(disease.name),
                    subtitle: Text(disease.advice),
                  ),
                );
              },
            ),
    );
  }
}