import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'my_app.dart';

String baseUrl = "";
String agroaAppId = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  runApp(const MyApp());
}

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: ".env");
    baseUrl = dotenv.get('BASE_URL', fallback: 'https://api.default.com');
    // Updated key to match AGROA_APP_ID as you specified in your .env
    agroaAppId = dotenv.get('AGROA_APP_ID', fallback: '');
    
    if (agroaAppId.isEmpty) {
      debugPrint("WARNING: AGROA_APP_ID is empty. Check your .env file.");
    } else {
      debugPrint("Env loaded successfully. App ID: ${agroaAppId.substring(0, 5)}***");
    }
  } catch (e) {
    debugPrint("Error loading .env file: $e");
    baseUrl = 'https://api.default.com';
    agroaAppId = '';
  }
}
