class SongEntity {
  final int id;
  final String title;

  final int albumId; // Foreign key to Album

  SongEntity({required this.id, required this.title, required this.albumId});
}
