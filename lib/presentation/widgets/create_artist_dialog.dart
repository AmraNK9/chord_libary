import 'package:chord_libary/data/model/z_models.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateArtistDialog extends StatelessWidget {
  CreateArtistDialog({super.key});
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              TextField(
                style: const TextStyle(color: Colors.white),
                controller: nameController,
                decoration: const InputDecoration(
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
                          onPressed: () {
                            final artist = Artist(
                                id: DateTime.now().microsecondsSinceEpoch,
                                name: nameController.text);
                            Navigator.of(context).pop(artist);
                          },
                          child: const Text("Save"))),
                ],
              )
            ],
          ),
        ));
  }
}
