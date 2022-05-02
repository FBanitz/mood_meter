// This software uses the CC BY-SA 4.0 license (https://creativecommons.org/licenses/by-sa/4.0/legalcode).

class MoodData {
  final DateTime date ;
  final int mood;

  MoodData({required this.date, this.mood = 0});

  @override
  String toString() {
    return 'MoodData{date: $date, mood: $mood}';
  }
}