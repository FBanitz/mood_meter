import 'dart:convert';

import 'package:mood_meter/models/mood_data.dart';
import 'package:mood_meter/models/user.dart';
import 'package:mood_meter/settings.dart';
import 'package:http/http.dart' as http;

class MoodAPI {
  static const String _baseUrl = Settings.moodAPIBaseURL;

  static Future<List<User>> getData() async {
    final response = await http.get(Uri(path: 'see_data', host: _baseUrl, scheme: 'http'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<User> users = [];
      jsonResponse.forEach((key, value) {
        if (key == "time") {
          value.forEach((name, times) {
            List<MoodData> moods = [];
            times.forEach((time) {
              if (time.isNotEmpty) {
                moods.add(MoodData(date: DateTime.fromMillisecondsSinceEpoch(int.parse(time.replaceAll(".", "").substring(0, 13)))));
              }
            });
            users.add(User(name: name, moods: moods));
          });
        }
      });
      jsonResponse.forEach((key, value) {
        if (key == "data") {
          value.forEach((name, moods) {
            for (var user in users) {
              if (user.name == name) {
                int i = 0;
                for (var mood in moods) {
                  int? moodInt = int.tryParse(mood);
                  if (moodInt != null && user.moods.length > i) {
                    if (moodInt > 10) {
                      moodInt = 10;
                    }
                    if (moodInt < 0) {
                      moodInt = 0;
                    }
                    MoodData moodData = MoodData(date: user.moods[i].date, mood: moodInt);
                    user.moods.remove(user.moods[i]);
                    user.moods.insert(i, moodData);
                  }
                  i++;
                }
              }
            }
          });
        }
      });

      return users;
    } else {
      throw Exception('Failed to load data');
    }

  }

  static Future<void> postData(String name, int mood) async {
    final response = await http.get(Uri(path: 'sur_10-$name-$mood', host: _baseUrl, scheme: 'http'));
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to load data');
    }
  }
}