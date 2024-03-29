import 'package:chord_libary/domain/enties/album_entity.dart';

class Album {
  final int id;
  final String title;
  final int artistId; // Foreign key to Artist

  Album({required this.id, required this.title, required this.artistId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artistId': artistId,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) => Album(
        id: map['id'] as int,
        title: map['title'] as String,
        artistId: map['artistId'] as int,
      );

  AlbumEntity toEntity() =>
      AlbumEntity(id: id, title: title, artistId: artistId);
}
