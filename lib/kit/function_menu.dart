import 'package:flutter/material.dart';
import '../schedule/schedule.dart';
import '../studyclock/studyclock.dart';
import '../shift/shift_schedule.dart';
import '../clock/clock.dart';
class FunctionMenu extends StatefulWidget{
  const FunctionMenu({super.key});
  @override
  State<FunctionMenu> createState() => _FunctionMenuState();
}

class _FunctionMenuState extends State<FunctionMenu>{
  late List<Widget> _list;

  @override
  void initState(){
    super.initState();
    _list = <Widget>[
      UserAccountsDrawerHeader(
        accountName: Text("ABC"),
        accountEmail: Text("address@example.com"),
        currentAccountPicture: Icon(Icons.person),
      ),
      ListTile(
        leading: const Icon(Icons.timeline),
        title: const Text('行程管理'),
        subtitle: const Text("編輯你的行程、代辦事項"),
        onTap: () => {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Schedule(),
              ),
              (route) => false,
          )
        },
      ),
      ListTile(
        leading: const Icon(Icons.access_time),
        title: const Text('學習/工作時鐘'),
        subtitle: const Text("番茄鐘、工作"),
        onTap: () => {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StudyClock(),
            ),
                (route) => false,
          )
        },
      ),
      ListTile(
        leading: const Icon(Icons.rule),
        title: const Text('班表'),
        subtitle: const Text("選取工作日期"),
        onTap: () => {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => ShiftSchedule(),
            ),
                (route) => false,
          )
        },
      ),
      ListTile(
        leading: const Icon(Icons.rule),
        title: const Text('時鐘管理'),
        subtitle: const Text("一切跟時間有關的都在這"),
        onTap: () => {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Clock(),
            ),
                (route) => false,
          )
        },
      ),
      ListTile(
        leading: CircleAvatar(child: Text("B")),
        title: Text('Bob'),
        subtitle: Text("Click to start talk"),
        onTap: () => {debugPrint('Bob')},
      ),
      ListTile(
        leading: CircleAvatar(child: Text("C")),
        title: Text('Cindy'),
        subtitle: Text("Click to start talk"),
        onTap: () => {debugPrint('Cindy')},
      ),
      const AboutListTile(
        child: Text("About this App"),
        icon: Icon(Icons.info),
      )
    ];
  }

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: _list
      )
    );
  }
}