import 'package:chord_libary/data/model/song.dart';

class SongEntity {
  final int id;
  final String title;

  final int albumId; // Foreign key to Album

  SongEntity({required this.id, required this.title, required this.albumId});

  Song toModel() {
    return Song(id: id, title: title, albumId: albumId);
  }
}
