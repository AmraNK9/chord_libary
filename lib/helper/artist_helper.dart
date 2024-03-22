import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/widgets/create_artist_dialog.dart';
import 'package:flutter/material.dart';

class ArtistHelper {
  final ArtistCubit artistCubit;
  ArtistHelper({required this.artistCubit});

  void createArtist(BuildContext context) async {
    final Artist artist = await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: CreateArtistDialog(),
          );
        });
    artistCubit.createAtist(artist);
  }
}
