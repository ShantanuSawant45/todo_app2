import 'package:flutter/material.dart';
import 'dart:async';

class ExerciseTimer extends StatefulWidget {
  final Duration duration;

  const ExerciseTimer({
    super.key,
    required this.duration,
  });

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  late Timer _timer;
  late Duration _currentDuration;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _currentDuration = widget.duration;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_currentDuration.inSeconds > 0) {
          _currentDuration = Duration(seconds: _currentDuration.inSeconds - 1);
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${_currentDuration.inMinutes}:${(_currentDuration.inSeconds % 60).toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _isRunning
              ? null
              : () {
                  setState(() {
                    _isRunning = true;
                    _startTimer();
                  });
                },
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start Exercise'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
}
