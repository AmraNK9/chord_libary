import 'package:chord_libary/data/model/album.dart';

class AlbumEntity {
  final int id;
  final String title;
  final int artistId; // Foreign key to Artist

  AlbumEntity({required this.id, required this.title, required this.artistId});

  Album toModal() {
    return Album(id: id, title: title, artistId: artistId);
  }
}
