import 'package:chord_libary/data/local_datasource.dart';
import 'package:chord_libary/data/models.dart';

class MusicLibraryRepository {
  MusicLibraryRepository._internal();

  static final MusicLibraryRepository _instance =
      MusicLibraryRepository._internal();

  factory MusicLibraryRepository() {
    return _instance;
  }

  final DatabaseHelper databaseHelper = DatabaseHelper();

  // Artist Functions
  Future<int> insertArtist(Artist artist) =>
      databaseHelper.insertArtist(artist);

  Future<List<Artist>> getArtists() => databaseHelper.getArtists();

  // Album Functions
  Future<int> insertAlbum(Album album) => databaseHelper.insertAlbum(album);

  Future<List<Album>> getAlbums() => databaseHelper.getAlbums();

  Future<List<Album>> getAlbumsByArtist(int artistId) =>
      databaseHelper.getAlbumsByArtist(artistId);

  // Song Functions
  Future<int> insertSong(Song song) => databaseHelper.insertSong(song);

  Future<List<Song>> getSongs() => databaseHelper.getSongs();

  Future<List<Song>> getSongsByArtist(int artistId) async {
    return await databaseHelper.getSongsByArtist(artistId);
  }

  Future<List<Song>> getSongsByAlbum(int albumId) async {
    return await databaseHelper.getSongsByAlbum(albumId);
  }
}
