import 'package:flutter/material.dart';

class FirebaseLogging {
  final String apiKey;
  final String projectId;

  FirebaseLogging({required this.apiKey, required this.projectId});

  void log(String message) {
    debugPrint(message);
  }
}
