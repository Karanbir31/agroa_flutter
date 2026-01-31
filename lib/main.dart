import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'my_app.dart';

String baseUrl = "";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  runApp(const MyApp());
}

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: ".env");
    baseUrl = dotenv.get('BASE_URL', fallback: 'https://api.default.com');
  } catch (e) {
    debugPrint("Error loading .env file: $e");
    baseUrl = 'https://api.default.com';
  }
}
