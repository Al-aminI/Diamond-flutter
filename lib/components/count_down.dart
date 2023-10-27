import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  final DateTime targetDateTime;

  const CountdownTimer({Key? key, required this.targetDateTime})
      : super(key: key);

  @override
  State createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration countdownDuration;
  late Timer countdownTimer;

  @override
  void initState() {
    super.initState();
    // Calculate the initial countdown duration
    calculateCountdown();
    // Start the countdown timer
    startCountdown();
  }

  void calculateCountdown() {
    final currentTime = DateTime.now();
    countdownDuration = widget.targetDateTime.isBefore(currentTime)
        ? const Duration(
            seconds: 0) // If the target time has passed, set duration to zero.
        : widget.targetDateTime.difference(currentTime);
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownDuration.inSeconds > 0) {
          countdownDuration -= const Duration(seconds: 1);
        } else {
          timer.cancel(); // Cancel the timer when the countdown is complete.
        }
      });
    });
  }

  @override
  void dispose() {
    countdownTimer.cancel(); // Cancel the timer to avoid memory leaks.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = countdownDuration.inDays;
    final hours = countdownDuration.inHours % 24;
    final minutes = countdownDuration.inMinutes % 60;
    final seconds = countdownDuration.inSeconds % 60;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          '$days days, $hours hrs, $minutes min, $seconds sec to go!',
          style: const TextStyle(
              color: Color.fromARGB(255, 44, 43, 43),
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
