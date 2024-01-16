import 'dart:async';

import 'package:flutter/material.dart';


class StopWatch extends StatefulWidget {
  const StopWatch({super.key});
  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int _seconds = 0;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Timer'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(_seconds),
              style: TextStyle(fontSize: 80, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isRunning = !_isRunning;
                      if (_isRunning) {
                        _startTimer();
                      } else {
                        _stopTimer();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _isRunning ? Colors.red : Colors.blue,
                  ),
                  child: Text(
                    _isRunning ? 'Pause' : 'Start',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _resetTimer();
                    _stopTimer();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Reset', style: TextStyle(fontSize: 20,color: Colors.white),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}