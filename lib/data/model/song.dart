import 'package:chord_libary/domain/enties/song_entity.dart';

class Song {
  final int id;
  final String title;

  final int albumId; // Foreign key to Album

  Song({required this.id, required this.title, required this.albumId});

  factory Song.fromMap(Map<String, dynamic> map) => Song(
        id: map['id'] as int,
        title: map['title'] as String,
        albumId: map['albumId'] as int,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'albumId': albumId,
    };
  }

  SongEntity toEntity() => SongEntity(id: id, title: title, albumId: albumId);
}
