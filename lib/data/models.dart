class Artist {
  final int id;
  final String name;

  Artist({required this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Artist fromMap(Map<String, dynamic> map) => Artist(
        id: map['id'] as int,
        name: map['name'] as String,
      );
}

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

  static Album fromMap(Map<String, dynamic> map) => Album(
        id: map['id'] as int,
        title: map['title'] as String,
        artistId: map['artistId'] as int,
      );
}

class Song {
  final int id;
  final String title;
  final int albumId; // Foreign key to Album

  Song({required this.id, required this.title, required this.albumId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'albumId': albumId,
    };
  }

  static Song fromMap(Map<String, dynamic> map) => Song(
        id: map['id'] as int,
        title: map['title'] as String,
        albumId: map['albumId'] as int,
      );
}
