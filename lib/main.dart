import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:xylophone/AudioControl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Xylophone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AudioControl());
  }
}
