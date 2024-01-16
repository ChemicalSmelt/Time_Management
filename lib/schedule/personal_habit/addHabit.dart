import 'dart:async';

import 'package:flutter/material.dart';
import 'habit.dart';

class AddHabit{
  static Completer<Habit?> habitCompleter = Completer<Habit?>();

  static void showAddHabitModal(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width, // 填滿整個畫面的寬度
          height: 200.0,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '新增習慣',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Transform.scale(
                scale: 1.5, // 養成按鈕的放大倍數
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);

                    var habit = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddHabitPage()),
                    );
                    debugPrint(habit.name);
                    habitCompleter.complete(habit);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // 修改按鈕顏色
                  ),
                  child: Text(
                    '養成習慣',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Transform.scale(
                scale: 1.5, // 戒除按鈕的放大倍數
                child: ElevatedButton(
                  onPressed: () {
                    // 戒除習慣的操作
                    Navigator.pop(context); // 關閉滑動視窗
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // 修改按鈕顏色
                  ),
                  child: Text(
                    '戒除習慣',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AddHabitPage extends StatefulWidget {
  @override
  _AddHabitPageState createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  late String habitName;
  late String selectedCategory = InterestCategory.learning.toString().split('.').last;
  late TimeOfDay startTime = TimeOfDay.now();
  late TimeOfDay endTime = TimeOfDay.now();

  final List<String> habitCategories = InterestCategory.values.map((e) => e.toString().split('.').last).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Habit Name'),
              onChanged: (value) {
                habitName = value;
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: habitCategories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Habit Category',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start Time: ${startTime.format(context)}'),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Select'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('End Time: ${endTime.format(context)}'),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text('Select'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                Habit newHabit = Habit(
                    name: habitName,
                    startTime: DateTime(0,0,0,startTime.hour, startTime.minute),
                    endTime: DateTime(0,0,0,endTime.hour, endTime.minute),
                    interestCategory: InterestCategory.values.firstWhere((e) => e.toString() == 'InterestCategory.$selectedCategory'),
                );

                // 使用 pop 返回數據
                Navigator.pop(context, newHabit);
              },
              child: Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
      });
    }
  }
}