import 'package:chord_libary/data/models.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'music_library.db';
  static const _artistTable = 'artists';
  static const _albumTable = 'albums';
  static const _songTable = 'songs';

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_databaseName';
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $_artistTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE
        )
      ''');

      db.execute('''
        CREATE TABLE $_albumTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          artistId INTEGER NOT NULL,
          FOREIGN KEY (artistId) REFERENCES $_artistTable(id)
        )
      ''');

      db.execute('''
        CREATE TABLE $_songTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          albumId INTEGER NOT NULL,
          FOREIGN KEY (albumId) REFERENCES $_albumTable(id)
        )
      ''');
    });
  }

  Future<int> insertArtist(Artist artist) async {
    final database = await this.database;
    final result = await database.insert(_artistTable, artist.toMap());
    return result;
  }

  Future<List<Artist>> getArtists() async {
    final database = await this.database;
    final maps = await database.query(_artistTable);
    return List.generate(maps.length, (i) => Artist.fromMap(maps[i]));
  }

  Future<int> insertAlbum(Album album) async {
    final database = await this.database;
    final result = await database.insert(_albumTable, album.toMap());
    return result;
  }

  Future<List<Album>> getAlbums() async {
    final database = await this.database;
    final maps = await database.query(_albumTable);
    return List.generate(maps.length, (i) => Album.fromMap(maps[i]));
  }

  Future<List<Album>> getAlbumsByArtist(int artistId) async {
    final database = await this.database;
    final maps = await database
        .query(_albumTable, where: 'artistId = ?', whereArgs: [artistId]);
    return List.generate(maps.length, (i) => Album.fromMap(maps[i]));
  }

  Future<int> insertSong(Song song) async {
    final database = await this.database;
    final result = await database.insert(_songTable, song.toMap());
    return result;
  }

  Future<List<Song>> getSongs() async {
    final database = await this.database;
    final maps = await database.query(_songTable);
    return List.generate(maps.length, (i) => Song.fromMap(maps[i]));
  }

  Future<List<Song>> getSongsByAlbum(int albumId) async {
    final database = await this.database;
    final maps = await database
        .query(_songTable, where: 'albumId = ?', whereArgs: [albumId]);
    return List.generate(maps.length, (i) => Song.fromMap(maps[i]));
  }

  Future<List<Song>> getSongsByArtist(int artistId) async {
    final database = await this.database;
    final maps = await database.rawQuery('''
      SELECT s.id, s.title, s.albumId
      FROM $_songTable AS s
      INNER JOIN $_albumTable AS a ON s.albumId = a.id
      WHERE a.artistId = ?
    ''', [artistId]);
    return List.generate(maps.length, (i) => Song.fromMap(maps[i]));
  }
}
