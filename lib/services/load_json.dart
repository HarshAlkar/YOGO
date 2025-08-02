import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/yoga_models.dart';

class YogaSessionService {
  static Future<YogaSession> loadYogaSession() async {
    try {
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assest/poses.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Parse the JSON into a YogaSession object
      return YogaSession.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load yoga session: $e');
    }
  }

  static Future<YogaSession> loadYogaSessionFromString(String jsonString) async {
    try {
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return YogaSession.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to parse yoga session: $e');
    }
  }
} 