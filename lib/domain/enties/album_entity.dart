class AlbumEntity {
  final int id;
  final String title;
  final int artistId; // Foreign key to Artist

  AlbumEntity({required this.id, required this.title, required this.artistId});
}
