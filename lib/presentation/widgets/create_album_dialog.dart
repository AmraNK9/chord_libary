import 'package:chord_libary/data/model/models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CreateAlbumDialog extends StatelessWidget {
  CreateAlbumDialog({super.key, required this.artists});
  // ignore: non_constant_identifier_names
  final List<Artist> artists;
  final TextEditingController nameController = TextEditingController();
  int? artistId;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Create New Album",
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
                  label: Text("Album Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownMenu(
                      textStyle: const TextStyle(color: Colors.white),
                      inputDecorationTheme: const InputDecorationTheme(
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.amber),
                        isDense: true,
                      ),
                      onSelected: (value) => artistId = value,
                      dropdownMenuEntries: artists
                          .map((e) => DropdownMenuEntry(
                              style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.black)),
                              value: e.id,
                              label: e.name))
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            final album = Album(
                                artistId: artistId!,
                                id: DateTime.now().microsecondsSinceEpoch,
                                title: nameController.text);
                            Navigator.of(context).pop(album);
                          },
                          child: const Text("Save"))),
                ],
              )
            ],
          ),
        ));
  }
}
