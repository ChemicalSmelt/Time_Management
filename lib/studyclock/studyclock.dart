import 'package:flutter/material.dart';

import '../kit/function_menu.dart';
import 'tomato/tomato.dart';
import 'work_time/work_time.dart';

class StudyClock extends StatefulWidget{
  final String title = "時鐘管理";
  const StudyClock({super.key});
  @override
  State<StudyClock> createState() => _ClockState();
}

class _ClockState extends State<StudyClock> with SingleTickerProviderStateMixin{
  TabController ?_controller;
  var _tabs = <Tab>[];

  @override
  void initState(){
    super.initState();
    _controller = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabs = <Tab>[
      const Tab(text: "番茄鐘",),
      const Tab(text: "工昨時間倒數",),
    ];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(tabs: _tabs,
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          indicatorSize: TabBarIndicatorSize.tab,
          controller: _controller,
        ),
      ),
      drawer: const FunctionMenu(),
      body: TabBarView(
          controller: _controller,
          children: const <Widget>[
            Center(
              child: PomodoroTimer(),
            ),
            Center(
              child: WorkTime(),
            ),
          ]
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
    _controller?.dispose();
  }
}