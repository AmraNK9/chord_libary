import 'package:chord_libary/domain/enties/artist_entity.dart';

class Artist {
  final int id;
  final String name;

  Artist({required this.id, required this.name});

  factory Artist.fromMap(Map<String, dynamic> map) => Artist(
        id: map['id'] as int,
        name: map['name'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  ArtistEntity toEntity() => ArtistEntity(id: id, name: name);
}
