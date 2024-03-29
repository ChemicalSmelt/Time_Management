import 'package:flutter/material.dart';
import 'package:time_management/schedule/personal_habit/habit.dart';
import 'pie.dart';
import 'dart:async';
import '../../plugins/notification.dart';

import 'addHabit.dart';


void main() {
  runApp(PersonalHabit());
}

class PersonalHabit extends StatefulWidget{
  const PersonalHabit({super.key});
  @override
  State<PersonalHabit> createState() => _PersonalHabitState();
}

class _PersonalHabitState extends State<PersonalHabit> {
  final PageController pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  int page = 0;
  List<Habit> habits = [
    Habit(name: 'Hello', startTime: DateTime(0,0,0,1,), endTime: DateTime(0,0,0,2,), interestCategory: InterestCategory.learning),
    Habit(name: 'Hello2', startTime: DateTime(0,0,0,2,), endTime: DateTime(0,0,0,3,), interestCategory: InterestCategory.learning),
    Habit(name: 'test', startTime: DateTime(0,0,0,11), endTime: DateTime(0,0,0,13), interestCategory: InterestCategory.learning),
    Habit(name: 'Hello3', startTime: DateTime(0,0,0,13,), endTime: DateTime(0,0,0,15,), interestCategory: InterestCategory.learning),
  ];

  late int sid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HabitSP.getCount().then((values){
      sid = values;
      setState(() {

      });
    });
    HabitSP.load().then((values){
      if(values != null){
        habits = values;
        setState(() {

        });
      }else{
        habits = [];
        setState(() {

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(
                height: 100.0,
                child: Stack(
                  children: [
                    PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: habits.map((Habit habit) {
                        return Center(child: ListTile(
                            title: Text(habit.name, textAlign: TextAlign.center,),
                        subtitle: Text(
                            '${habit.startTime.hour}:${habit.startTime.minute} - ${habit.endTime.hour}:${habit.endTime.minute}',
                            textAlign: TextAlign.center,
                        )),);
                      }).toList(),
                      onPageChanged: (int page){
                        this.page = page;
                        setState(() {

                        });
                      },
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          if (pageController.page! > 0) {
                            pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          if (pageController.page! < habits.length - 1) {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height:  20,),
              // 中間圓餅圖
              Container(
                child: PieChartSample3(habits: habits, selectHabit: habits.length <= page ? '' : habits[page].name,)
              ),
            ],
          )
        ),
        floatingActionButton:
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () async {
                  AddHabit.showAddHabitModal(context);

                  AddHabit.habitCompleter = Completer<Habit?>();
                  var habit = await AddHabit.habitCompleter.future;
                  debugPrint('test');
                  if(habit != null && habit is Habit) {
                    debugPrint('ok');
                    bool flag = true;
                    for (var h in habits) {
                      if (habit.startTime.isAfter(h.startTime) &&
                          habit.startTime.isBefore(h.endTime)) {
                        flag = false;
                        break;
                      }
                      if (habit.endTime.isAfter(h.startTime) &&
                          habit.endTime.isBefore(h.endTime)) {
                        flag = false;
                        break;
                      }
                    }
                    if (flag) {
                      habit.setSid(sid);
                      habits.add(habit);
                      await HabitSP.store(habits);
                      NotificationPlugin().scheduleDayNotification(sid, '習慣提醒', habit.name, habit.startTime.hour, habit.startTime.minute);
                      setState(() {

                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('有重複的時間喔!!!'),
                        ),
                      );
                    }
                  }

              },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () async {
                  if(habits.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('目前還沒有添加習慣喔!!!'),
                      ),
                    );
                  }else{
                    NotificationPlugin().removeScheduledNotification(habits[page].sid ?? 10000);
                    habits.removeAt(page);
                    await HabitSP.store(habits);
                    setState(() {

                    });
                  }
                },
                tooltip: 'Increment',
                child: Icon(Icons.delete),
              ),
          ]
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}