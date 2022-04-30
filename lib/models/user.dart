// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

import 'package:mood_meter/models/mood_data.dart';

class User {
  String name;
  List<MoodData> moods;
  User({this.name = "", this.moods = const[]});
}