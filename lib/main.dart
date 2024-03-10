import 'package:chord_libary/home/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MusicLibery());
}

class MusicLibery extends StatelessWidget {
  const MusicLibery({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(
        title: 'Chord Libery',
      ),
    );
  }
}
