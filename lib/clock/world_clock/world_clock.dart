import 'dart:async';
import 'package:flutter/material.dart';


class WorldClock extends StatefulWidget {
  const WorldClock({super.key});
  @override
  State<WorldClock> createState() => _WorldClockState();
}

class _WorldClockState extends State<WorldClock> {
  int selectedIndex = 0; // Index for selected city
  List<String> cities = ['London', 'New York', 'Taipei', 'Japan',];
  List<String> times = ['Loading...', 'Loading...', 'Loading...', 'Loading...'];

  @override
  void initState() {
    super.initState();
    // Start the periodic timer for updating time
    Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    DateTime now = DateTime.now();
    List<DateTime> cityTimes = [
      now.toLocal().add(Duration(hours: 0)),
      now.toLocal().add(Duration(hours: -5)),
      now.toLocal().add(Duration(hours: 8)),
      now.toLocal().add(Duration(hours: 9)),
    ];
    if (mounted) {
      setState(() {
        for (int i = 0; i < cities.length; i++) {
          times[i] =
          '${cityTimes[i].hour}:${cityTimes[i].minute}:${cityTimes[i].second}';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('World Time App'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              cities[selectedIndex],
              style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '${times[selectedIndex]}',
              style: TextStyle(fontSize: 50.0, color: Colors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        selectedFontSize: 22,
        unselectedFontSize: 15,
        iconSize: 30,
        items: cities.map((city) {
          return BottomNavigationBarItem(
            icon: Icon(Icons.place, color: Colors.white),
            label: city,
            backgroundColor: Colors.blue,
            //unselectedLabelStyle: TextStyle(color: Colors.white),
          );
        }).toList(),
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

      ),
    );
  }
}