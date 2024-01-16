import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class Habit{
  final DateTime startTime;
  final DateTime endTime;

  final String name;
  final InterestCategory interestCategory;

  Habit({required this.name, required this.startTime, required this.endTime, required this.interestCategory});


  static fromJson(Map<String, dynamic> jsonData) {
    return Habit(
      name: jsonData['name'],
      startTime: DateTime.parse(jsonData['startTime']),
      endTime: DateTime.parse(jsonData['endTime']),
      interestCategory: InterestCategory.values.firstWhere((e) => e.toString() == jsonData['interestCategory']),
    );
  }

  static Map<String, dynamic> toMap(Habit habit) => {
    'name' : habit.name,
    'startTime' : habit.startTime.toString(),
    'endTime' : habit.endTime.toString(),
    'interestCategory' : habit.interestCategory.toString(),
  };
}

class HabitSP{
  static store(List<Habit> habits) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(
        habits
            .map<Map<String, dynamic>>((music) => Habit.toMap(music))
            .toList());

    await prefs.setString('Habits', encodedData);
  }

  static load() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? habitsString = prefs.getString('Habits');
    if(habitsString != null) {
      List<Habit> habits = (json.decode(habitsString) as List<dynamic>)
        .map<Habit>((item) => Habit.fromJson(item))
        .toList();
      return habits;
    }
  }
}

enum InterestCategory {
  sports,
  learning,
  reading,
  movies,
}