import 'package:chord_libary/components/dialogs/comfirm_dialog.dart';
import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/data/model/z_models.dart';
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
                  if (state.state == CrudState.fetchSuccess) {
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

  void deleteAlbum(BuildContext context, Album album) async {
    final isSure = await showConfirmDialog(context,
        label: ' ${album.title} will be delete!');

    if (isSure ?? false) albumsCubit.deleteAlbum(album);
    debugPrint("________Delete in Helper________");
  }
}
