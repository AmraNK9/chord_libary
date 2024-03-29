import 'package:chord_libary/helper/album_helper.dart';
import 'package:chord_libary/helper/artist_helper.dart';
import 'package:chord_libary/helper/song_helper.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';

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
                getIt<ArtistHelper>().createArtist(context);
              },
              title: const Text("Create New Artist"),
            ),
            ListTile(
              onTap: () {
                getIt<AlbumHelper>().createAlbum(context);
              },
              title: const Text("Create New Album"),
            ),
            ListTile(
              onTap: () {
                getIt<SongHelper>().createSong(context);
              },
              title: const Text("Create New Song"),
            )
          ],
        ), // This can be any widget.
      ),
    );
  }
}
