import 'package:flutter/material.dart';

class AddSongDialog extends StatelessWidget {
  const AddSongDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog.fullscreen(
      child: SingleChildScrollView(
        child: Column(
          children: [Text("Add Dialog")],
        ),
      ),
    );
  }
}
