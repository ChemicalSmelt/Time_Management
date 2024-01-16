import 'package:flutter/material.dart';
import '../kit/function_menu.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App介紹',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroductionScreen(),
    );
  }
}
class IntroductionScreen extends StatelessWidget {

  void showAlertDialog(BuildContext context,int index) {

    AlertDialog dialog = AlertDialog(
      title:Image(
        image: AssetImage('assets/images/'+index.toString()+'.gif'),
        width: 300, // 设置宽度
        height:500,
        fit: BoxFit.cover,// 设置高度
      ),
      actions: [
        ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('App介紹'),
      ),
      drawer: const FunctionMenu(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50.0),
                  child:  Text(
                    '歡迎使用我們的App！',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '這是一個有關於時間管理的APP。我們有以下功能',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 15.0,
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '行程安排:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:77.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,1);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left: 50.0),
                  child:Column(
                    children: [
                      Text(
                        '       1.規劃日後行程',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2.明顯標註',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3.提前通知',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '學習時鐘(番茄鐘):',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:15.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,2);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left: 38.0),
                  child:Column(
                    children: [
                      Text(
                        '1.效率學習',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2.自訂時間',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3.聆聽音樂',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '          4.休息/學習 提醒',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      //示範影片還需更改
                      '工作表:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:90.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,3);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left:45.0),
                  child:Column(
                    children: [
                      Text(
                        '        1.紀錄工作天數',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ' 2.明顯標註',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),

                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '待辦事項:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:75.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,4);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left:34.0),
                  child:Column(
                    children: [
                      Text(
                        '       1.紀錄當天所需',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '           2.可分重要與普通',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3.即時通知',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '個人習慣:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:75.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,5);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding:EdgeInsets.only(left:20.0),
                  child:Column(
                    children: [
                      Text(
                        '       1.設定個人習慣',
                        style: TextStyle(fontSize: 16),
                      ),

                      Text(
                        '               2.可設定多樣的習慣',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '3.即時通知',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '       4.分早上與晚上',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '學習時鐘(工作時間):',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        this.showAlertDialog(context,6);

                      },
                      child: Icon(
                        Icons.smart_display,
                        size: 45,
                      ),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                      ),
                    ),SizedBox(height: 5,width: 5,),

                  ],

                ),
                Padding(
                  padding:EdgeInsets.only(left: 80.0),
                  child:Column(
                    children: [
                      Text(
                        '1.效率工作',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '2.自訂時間',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '碼表:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:105.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,7);

                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],

                ),
                Padding(
                  padding:EdgeInsets.only(left: 80.0),
                  child:Column(
                    children: [
                      Text(
                        '1.計算時間',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 15.0, // 設定圓點的直徑
                      height: 15.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black, // 設定圓點的顏色
                      ),
                    ),
                    Text(
                      '世界時鐘:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Padding(padding:EdgeInsets.only(left:75.0),
                      child:ElevatedButton(
                        onPressed: () {
                          this.showAlertDialog(context,8);
                        },
                        child: Icon(
                          Icons.smart_display,
                          size: 45,
                        ),
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal:0, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:EdgeInsets.only(left: 80.0),
                  child:Column(
                    children: [
                      Text(
                        '1.得知不同區域時間',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}