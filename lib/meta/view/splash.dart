import 'dart:async';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {});
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Icon(
          Icons.pedal_bike_rounded,
          color: Theme.of(context).primaryColor,
          size: 120,
        ),
      ),
    );
  }
}
