import 'package:chord_libary/data/model/artist.dart';

class ArtistEntity {
  final int id;
  final String name;

  ArtistEntity({required this.id, required this.name});

  Artist toModel() {
    return Artist(id: id, name: name);
  }
}
