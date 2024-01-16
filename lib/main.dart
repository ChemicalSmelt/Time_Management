import 'package:flutter/material.dart';
import 'schedule/schedule.dart';
import 'package:table_calendar/table_calendar.dart';
import 'plugins/notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/date_symbol_data_local.dart';

import 'schedule/personal_habit/personal_habit.dart';


void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Management',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Schedule(),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum VerticalFlipShowingType {
  calendar,
  all,
}

class _MyHomePageState extends State<MyHomePage> {
  VerticalFlipShowingType headerFlipShowingType = VerticalFlipShowingType.calendar;
  final ScrollController scrollController = ScrollController();
  final double headerFlipThreshold = 50;
  final double headerFlipHeightA = 400;
  final double headerFlipHeightB = 0;
  double get headerFlipHeight => headerFlipHeightA + headerFlipHeightB;
  var currentIndex = -1;
  late List<int> mList;

  @override
  void initState(){
    super.initState();
    mList = [];
    for(int i = 0; i < 3;i++){
      mList.add(i);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: CustomScrollView(
        slivers: [

          SliverToBoxAdapter(child: _buildHeaderWidget()),
          SliverToBoxAdapter(
            child: IconButton(
              icon: headerFlipShowingType == VerticalFlipShowingType.calendar ?
              const Icon(Icons.keyboard_double_arrow_up) :
              const Icon(Icons.keyboard_double_arrow_down),
              onPressed: (){
                setState(() {
                  headerFlipShowingType =
                  headerFlipShowingType == VerticalFlipShowingType.calendar
                      ? VerticalFlipShowingType.all
                      : VerticalFlipShowingType.calendar;
                });
              },
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                  child: ExpansionPanelList(
                    expansionCallback: (index, isExpanded){
                      setState(
                          () {
                            currentIndex = (currentIndex != index)?index : -1;
                          }
                      );
                    },
                    children: mList.map(
                            (i) {
                          return ExpansionPanel(
                            headerBuilder: (BuildContext context, bool isExpanded){
                              return ListTile(
                                title: Text(i.toString()),
                              );
                            },
                            body: ListTile(
                                title: Text(i.toString()),
                                ),
                            isExpanded: currentIndex ==i ,
                          );
                        }
                    ).toList(),
                  )
              )
          ),

          // header（AAA + BBB）

          SliverList( // 正常的列表 （显示：index -- 下标）
            delegate: SliverChildBuilderDelegate(
                  (ctx, index) {
                return ListTile(title: Text("index -- $index"));
              },
              childCount: 40,
            ),
          )
        ],
      ),

    // 右下角的浮动按钮，用来切换 header
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    setState(() {
      headerFlipShowingType =
      headerFlipShowingType == VerticalFlipShowingType.calendar
      ? VerticalFlipShowingType.all
          : VerticalFlipShowingType.calendar;
      });
      },
    ),
    );
  }

  Widget _buildHeaderWidget() {
    return SizedBox( // 限制 Stack 的高度，否则报错
      height: headerFlipShowingType == VerticalFlipShowingType.calendar
          ? headerFlipHeightA
          : headerFlipHeightB,
      child : Stack(
      clipBehavior: Clip.none, // 子视图超出 Stack 不裁剪，依旧显示
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: headerFlipHeight, // AAA 与 BBB 加起来的总高度
          child: ListView(
            padding: EdgeInsets.zero, // 消除顶部刘海造成的安全区域偏移
            physics: const NeverScrollableScrollPhysics(), // 不可滚动
            children: [
              SizedBox(
                height: headerFlipHeightA,
                child: null//Calendar(),
              ),
              SizedBox(
                height: headerFlipHeightB,
                child: const HeaderFlipWidget(
                  text: "",
                  color: Color(0xFF228BE6),
                ),
              ),
            ],
          ),
        )
      ],
    ),
    );
  }
}

class HeaderFlipWidget extends StatelessWidget {
  final String text;
  final Color? color;

  const HeaderFlipWidget({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.pink,
      child: Center(
        child: Text(
          text,
          textScaleFactor: 5,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

*/
