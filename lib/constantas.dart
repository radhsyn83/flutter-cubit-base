// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

// https://mock.codes/200

class Constanta {
  static String get BASE_URL => dotenv.get("BASE_URL");
}
