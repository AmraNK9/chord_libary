import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CreateAlbumDialog extends StatelessWidget {
  CreateAlbumDialog({super.key});
  // ignore: non_constant_identifier_names
  late AlbumsCubit AlbumCubit;
  late ArtistCubit artistCubit;
  final TextEditingController nameController = TextEditingController();
  int? artistId;
  void _onSaveHandler() {
    final album = Album(
        artistId: artistId!,
        id: DateTime.now().microsecondsSinceEpoch,
        title: nameController.text);
    AlbumCubit.createAlbum(album);
  }

  @override
  Widget build(BuildContext context) {
    artistCubit = context.read<ArtistCubit>();
    AlbumCubit = context.read<AlbumsCubit>();
    artistCubit.getArtist();
    return Dialog(
      child: Container(
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
                BlocBuilder<ArtistCubit, ArtistState>(
                  builder: (context, state) {
                    if (state is FetchArtistSuccess) {
                      return Row(
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
                              dropdownMenuEntries: state.artists
                                  .map((e) => DropdownMenuEntry(
                                      style: const ButtonStyle(
                                          foregroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.black)),
                                      value: e.id,
                                      label: e.name))
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    }
                    return const DropdownMenu(dropdownMenuEntries: []);
                  },
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
