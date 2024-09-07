import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppData {
  static  String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String hiveBoxName = 'chatBox';
}