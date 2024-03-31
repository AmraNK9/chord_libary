import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

enum CreatingType { artist, song, album }

class CreateDialog extends StatelessWidget {
  const CreateDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FluidDialog(
      // Set the first page of the dialog.
      rootPage: FluidDialogPage(
        alignment: Alignment.center, //Aligns the dialog to the bottom left.

        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).pop(CreatingType.artist);
                // getIt<ArtistHelper>().createArtist(context);
              },
              title: const Text("Create New Artist"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop(CreatingType.album);
                // getIt<AlbumHelper>().createAlbum(context);
              },
              title: const Text("Create New Album"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop(CreatingType.song);
                // SongHelper(songsCubit: songCubit).createSong(context);
              },
              title: const Text("Create New Song"),
            )
          ],
        ), // This can be any widget.
      ),
    );
  }
}
