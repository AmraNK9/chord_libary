import 'package:flutter/material.dart';

class CreateArtistDialog extends StatelessWidget {
  const CreateArtistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "Create New Artist",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),
                const TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    label: Text("Artist Name"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Save"))),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
