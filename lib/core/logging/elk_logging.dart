import 'package:flutter/material.dart';

class ElkLogging {
  final String baseUrl;
  final String index;
  final String username;
  final String password;

  ElkLogging({
    required this.baseUrl,
    required this.index,
    required this.username,
    required this.password,
  });

  void log(String message) {
    final url = '$baseUrl/$index';
    final body = {'message': message};
    debugPrint(url);
    debugPrint(body.toString());
  }
}
