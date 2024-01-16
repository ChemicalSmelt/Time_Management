import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class WorkTime extends StatelessWidget {
  const WorkTime({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CountdownScreen(),
        ),
      );
  }
}

class CountdownScreen extends StatefulWidget {

  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int totalMinutes = 0;
  int totalSeconds = 5;
  int currentTime = 5;
  Timer? timer;
  bool isCountingDown = false;

  void startTimer() {
    if(isCountingDown){
      setState(() {
        isCountingDown = false;
      });
      stopTimer();
    }else{
      setState(() {
        isCountingDown = true;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (currentTime > 0) {
            currentTime -= 1;
          } else {
            currentTime = totalSeconds;
            stopTimer();
          }
        });
      });
    }
  }

  void stopTimer() {
    if (timer != null && timer!.isActive) {
      timer?.cancel();
      setState(() {
        isCountingDown = false;
      });
    }
  }
  void resetTimer(){
    setState(() {
      totalMinutes = 0;
      totalSeconds = 5;
      currentTime = 5;
    });
    stopTimer();
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CountdownCircle(
                totalTime: totalMinutes*60+totalSeconds,
                currentTime: currentTime,
                isCountingDown: isCountingDown,
              ),
            ],
          ),
        ),
        //SizedBox(height: 20),
        Column(
          children: [
            Text(
              '分',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white ,
              ),
            ),
            NumberPicker(
              value: totalMinutes,
              minValue: 0,
              maxValue: 59,
              step: 1,
              axis: Axis.horizontal,
              textStyle: TextStyle(
                color: Colors.white,  // 設置數字顏色為白色
                fontSize: 20,  // 調整字體大小
              ),
              selectedTextStyle: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
              onChanged: (value) {
                setState(() {
                  totalMinutes = value;
                  currentTime = value*60+totalSeconds;
                });
              },
            ),
          ],
        ),
        //SizedBox(width: 16),
        Column(
          children: [
            Text(
              '秒',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white ,
              ),
            ),
            NumberPicker(
              value: totalSeconds,
              minValue: 1,
              maxValue: 59,
              step: 1,
              axis: Axis.horizontal,
              textStyle: TextStyle(
                color: Colors.white,  // 設置數字顏色為白色
                fontSize: 20,  // 調整字體大小
              ),
              selectedTextStyle: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
              onChanged: (value) {
                setState(() {
                  totalSeconds = value;
                  currentTime = value+totalMinutes*60;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Icon(
                !isCountingDown ? Icons.play_circle_outline_outlined : Icons.stop_circle_rounded ,
                size: 50,
              ),
            ),
            SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                resetTimer();
              },
              child: Icon(
                Icons.refresh,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CountdownCircle extends StatelessWidget {
  final int totalTime;
  final int currentTime;
  final bool isCountingDown;

  const CountdownCircle({super.key,
    required this.totalTime,
    required this.currentTime,
    required this.isCountingDown,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      child: CustomPaint(
        size: Size.infinite,
        painter: CountdownPainter(currentTime.toDouble() / totalTime ),
        child: Center(
          child: CountdownText(currentTime, isCountingDown),
        ),
      ),
    );
  }
}

class CountdownPainter extends CustomPainter {
  final double progress;

  CountdownPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    double radius = size.width / 1.2;
    Offset center = Offset(size.width / 2, size.height / 2 + 100);

    canvas.drawCircle(center, radius, paint);

    Paint progressPaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    double arcAngle = 2 * pi * progress;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CountdownText extends StatelessWidget {
  final int time;
  final bool isCountingDown;

  CountdownText(this.time, this.isCountingDown);

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int remainingSeconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Center(
        child: Text(
          formatTime(time),
          style: TextStyle(
            fontSize: 50,
            color: Colors.white ,
            height: 7,
          ),
        ),
      ),
    );
  }
}