import 'package:chord_libary/components/dialogs/comfirm_dialog.dart';
import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:chord_libary/presentation/widgets/create_song_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongHelper {
  final SongsCubit songsCubit;
  SongHelper({required this.songsCubit});

  void createSong(BuildContext context) async {
    final Song song = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: BlocProvider(
              create: (context) => getIt<AlbumsCubit>()..getAlbums(),
              child: BlocBuilder<AlbumsCubit, AlbumCrudState>(
                builder: (context, state) {
                  if (state.state == CrudState.fetchSuccess) {
                    return CreateSongDialog(
                      albums: state.albums,
                    );
                  }
                  return const Center(
                    child: Text('Loading'),
                  );
                },
              ),
            ),
          );
        });
    songsCubit.createSong(song);
  }

  void deleteSong(BuildContext context, Song song) async {
    final isSure = await showConfirmDialog(context);
    if (isSure ?? false) songsCubit.deleteSong(song);
  }
}
