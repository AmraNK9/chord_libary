import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/widgets/create_album_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumHelper {
  final AlbumsCubit albumsCubit;
  AlbumHelper({required this.albumsCubit});

  void createAlbum(BuildContext context) async {
    final Album album = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: BlocProvider(
              create: (context) => getIt<ArtistCubit>()..getArtist(),
              child: BlocBuilder<ArtistCubit, ArtistState>(
                builder: (context, state) {
                  if (state is FetchArtistSuccess) {
                    return CreateAlbumDialog(
                      artists: state.artists,
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
    albumsCubit.createAlbum(album);
  }
}
