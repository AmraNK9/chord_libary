import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CreateArtistDialog extends StatelessWidget {
  CreateArtistDialog({super.key});
  late ArtistCubit artistCubit;
  final TextEditingController nameController = TextEditingController();

  void _onSaveHandler() {
    final artist = Artist(
        id: DateTime.now().microsecondsSinceEpoch, name: nameController.text);
    artistCubit.createAtist(artist);
  }

  @override
  Widget build(BuildContext context) {
    artistCubit = context.read<ArtistCubit>();
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
                              _onSaveHandler();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Save"))),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
