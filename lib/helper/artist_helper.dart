import 'package:chord_libary/core/extensions/navigator.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/widgets/create_artist_dialog.dart';
import 'package:flutter/material.dart';

class ArtistHelper {
  final ArtistCubit artistCubit;
  ArtistHelper({required this.artistCubit});

  void createArtist(BuildContext context) async {
    context.pop();
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
