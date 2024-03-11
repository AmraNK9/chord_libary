import 'package:chord_libary/core/theme.dart';
import 'package:chord_libary/home/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MusicLibery());
}

class MusicLibery extends StatelessWidget {
  const MusicLibery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.get(isLight: true),
      darkTheme: AppTheme.get(isLight: false),
      home: const Home(
        title: 'Chord Libery',
      ),
    );
  }
}
