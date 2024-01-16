import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'habit.dart';
import 'clockMarks.dart';
import '_badge.dart';

import 'dart:math' as math;

class PieChartSample3 extends StatefulWidget {
  late List<Habit> habits;
  List<Habit> habitsAM = [];
  List<Habit> habitsPM = [];
  late String selectHabit;
  PieChartSample3({super.key, required this.habits, required this.selectHabit}){
    List<Habit> temp= [];
    sort();
    DateTime start = DateTime(
      0,   // 使用當前年份
      0,  // 使用當前月份
      0,    // 使用當前日
      0,         // 設定為中午 12 點
      0,         // 設定分鐘為 30
      0,          // 設定秒為 0
      0,          // 設定毫秒為 0
      0,          // 設定微秒為 0
    );
    DateTime amEnd = DateTime(0,0,0,11,59);
    DateTime pmStart = DateTime(0,0,0,12,0);
    DateTime end = DateTime(
      0,   // 0
      0,  // 0
      0,    // 0
      23,         // 23
      59,         // 59
      0,          // 0
      0,          // 0
      0,          // 0
    );
    int i = 0;
    for(i; i < habits.length; ++i){
      if(habits[i].startTime.isAfter(amEnd)){
        break;
      }
      habitsAM.add(Habit(name: "", startTime: start, endTime: habits[i].startTime, interestCategory: InterestCategory.learning));
      if(habits[i].endTime.isAfter(amEnd)) {
        habitsAM.add(Habit(name: habits[i].name, startTime: habits[i].startTime, endTime: amEnd, interestCategory: habits[i].interestCategory));
        habitsPM.add(Habit(name: habits[i].name, startTime: pmStart, endTime: habits[i].endTime, interestCategory: habits[i].interestCategory));
      }else{
        habitsAM.add(habits[i]);
      }
      start = habits[i].endTime;
    }
    if(start.isBefore(amEnd)){
      habitsAM.add(Habit(name: "", startTime: start, endTime: amEnd, interestCategory: InterestCategory.learning));
      start = pmStart;
    }
    for(i; i < habits.length; ++i){
      habitsPM.add(Habit(name: "", startTime: start, endTime: habits[i].startTime, interestCategory: InterestCategory.learning));
      habitsPM.add(habits[i]);
      start = habits[i].endTime;
    }
    habitsPM.add(Habit(name: "", startTime: start, endTime: end, interestCategory: InterestCategory.learning));

    debugPrint('--------AM---------\n');
    for(var am in habitsAM){
      debugPrint(am.name.toString());
      debugPrint(am.startTime.toString());
      debugPrint(am.endTime.toString());
      debugPrint('-------------------\n');
    }
    debugPrint('--------PM---------\n');
    for(var pm in habitsPM){
      debugPrint(pm.name.toString());
      debugPrint(pm.startTime.toString());
      debugPrint(pm.endTime.toString());
      debugPrint('-------------------\n');
    }

    start = DateTime(0,0,0,0);
    end = DateTime(0,0,0,23,59);

    for(Habit habit in habits){
      temp.add(Habit(name: "", startTime: start, endTime: habit.startTime, interestCategory: InterestCategory.learning));
      temp.add(habit);
      start = habit.endTime;
    }
    temp.add(Habit(name: "", startTime: start, endTime: end, interestCategory: InterestCategory.learning));
    habits = temp;
  }

  @override
  State<PieChartSample3> createState() => PieChartSample3State();

  void sort(){
    habits.sort(
        (a, b){
          var aDate = a.startTime;
          var bDate = b.startTime;
          return aDate.compareTo(bDate);
        }
    );
  }
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = 0;
  PageController _pageController = PageController(viewportFraction: 1.1);
  List<Padding> _sections = [];
  int currentPage = 0; // 預設頁面為第一頁

  Padding getPie(List<Habit> habits){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child:
        //ClockMarks(),
          AspectRatio(
            aspectRatio: 4 / 3,
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  startDegreeOffset: -90,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex =
                            pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },

                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.white,
                      width: 20.0,
                    ),
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: showingSections(habits),

                ),
              ),
            ),
          ),

    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _sections = [];
    _sections.add(getPie(widget.habitsAM));
    _sections.add(getPie(widget.habitsPM));

    return SizedBox(
      height: 400.0,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/clock.jpg',
              fit: BoxFit.fill,
            ),
          ),
          PageView(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (int page){
              currentPage = page;
              setState(() {

              });
            },
            children: _sections,
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_left),
              onPressed: () {
                if (_pageController.page! > 0) {
                  _pageController.previousPage(
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
                if (_pageController.page! < _sections.length - 1) {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<Habit> newHabits) {
    int i = 0;
    return newHabits.map((Habit habit) {
      //final isTouched = i == touchedIndex;++i;
      final isTouched = habit.name == widget.selectHabit;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 160.0 : 150.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      debugPrint(habit.startTime.toString());
      debugPrint(habit.endTime.toString());
      debugPrint("-----------------");
      if(habit.name == ''){
        return PieChartSectionData(
          color: Colors.grey,
          value: (habit.endTime.difference(habit.startTime)).inMinutes.toDouble(),
          title: habit.name,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgePositionPercentageOffset: .98,
        );
      }else {
        return PieChartSectionData(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
          value: (habit.endTime.difference(habit.startTime)).inMinutes.toDouble(),
          title: habit.name,
          radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
          badgeWidget: NBadge(
            'assets/icons/ophthalmology-svgrepo-com.svg',
            size: widgetSize,
            borderColor: Colors.black,
          ),
          badgePositionPercentageOffset: .98,
        );
      }
    }).toList();
  }
}
