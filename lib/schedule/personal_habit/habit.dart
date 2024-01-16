import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class Habit{
  final DateTime startTime;
  final DateTime endTime;

  final String name;
  final InterestCategory interestCategory;

  int? sid;
  Habit.withId({required this.sid, required this.name, required this.startTime, required this.endTime, required this.interestCategory});
  Habit({required this.name, required this.startTime, required this.endTime, required this.interestCategory});

  setSid(int id){
    sid = id;
  }

  static fromJson(Map<String, dynamic> jsonData) {
    return Habit.withId(
      sid: jsonData['id'],
      name: jsonData['name'],
      startTime: DateTime.parse(jsonData['startTime']),
      endTime: DateTime.parse(jsonData['endTime']),
      interestCategory: InterestCategory.values.firstWhere((e) => e.toString() == jsonData['interestCategory']),
    );
  }

  static Map<String, dynamic> toMap(Habit habit) => {
    'id' : habit.sid ?? 10000,
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

  static getCount() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final int? i = prefs.getInt('counter');
    if(i != null){
      return i;
    }
    return 10000;
  }

  static setCount(int i) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('counter', i);
  }
}

enum InterestCategory {
  learning,
  diary,
  hiking,
  nap,
  yoga,
  music,
  computer,
}

Map<InterestCategory, String> s = {for (var tag in InterestCategory.values)
  tag: 'assets/images/${tag.toString().split('.').last}.png'};