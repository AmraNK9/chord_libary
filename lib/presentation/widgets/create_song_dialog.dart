import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CreateSongDialog extends StatelessWidget {
  CreateSongDialog({super.key});
  // ignore: non_constant_identifier_names
  late AlbumsCubit albumsCubit;
  final TextEditingController nameController = TextEditingController();
  int? albumId;

  @override
  Widget build(BuildContext context) {
    albumsCubit = context.read<AlbumsCubit>()..getAlbums();
    return Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Create New Song",
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
                  label: Text("Song Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<AlbumsCubit, AlbumsState>(
                builder: (context, state) {
                  if (state is FetchAlbumsSuccess) {
                    return Row(
                      children: [
                        Expanded(
                          child: DropdownMenu(
                            textStyle: const TextStyle(color: Colors.white),
                            inputDecorationTheme:
                                const InputDecorationTheme(isDense: true),
                            onSelected: (value) => albumId = value,
                            dropdownMenuEntries: state.Albumss.map((e) =>
                                DropdownMenuEntry(
                                    value: e.id, label: e.title)).toList(),
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
                            final song = Song(
                                albumId: albumId!,
                                id: DateTime.now().microsecondsSinceEpoch,
                                title: nameController.text);
                            Navigator.of(context).pop(song);
                          },
                          child: const Text("Save"))),
                ],
              )
            ],
          ),
        ));
  }
}
