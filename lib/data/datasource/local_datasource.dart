import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
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

  Future<Either<Failure, int>> insertArtist(Artist artist) async {
    try {
      final database = await this.database;
      final result = await database.insert(
        _artistTable,
        artist.toMap(),
      );
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Artist>>> getArtists() async {
    try {
      final database = await this.database;
      final maps = await database.query(_artistTable);
      final artistList =
          List.generate(maps.length, (i) => Artist.fromMap(maps[i]));
      return Right(artistList);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, int>> insertAlbum(Album album) async {
    try {
      final database = await this.database;
      final result = await database.insert(_albumTable, album.toMap());
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Album>>> getAlbums() async {
    try {
      final database = await this.database;
      final maps = await database.query(_albumTable);
      final result = List.generate(maps.length, (i) => Album.fromMap(maps[i]));
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Album>>> getAlbumsByArtist(int artistId) async {
    try {
      final database = await this.database;
      final maps = await database
          .query(_albumTable, where: 'artistId = ?', whereArgs: [artistId]);
      final result = List.generate(maps.length, (i) => Album.fromMap(maps[i]));
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, int>> insertSong(Song song) async {
    try {
      final database = await this.database;
      final result = await database.insert(_songTable, song.toMap());
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Song>>> getSongs() async {
    try {
      final database = await this.database;
      final maps = await database.query(_songTable);
      final result = List.generate(maps.length, (i) => Song.fromMap(maps[i]));
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Song>>> getSongsByAlbum(int albumId) async {
    try {
      final database = await this.database;
      final maps = await database
          .query(_songTable, where: 'albumId = ?', whereArgs: [albumId]);
      final result = List.generate(maps.length, (i) => Song.fromMap(maps[i]));

      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<Song>>> getSongsByArtist(int artistId) async {
    try {
      final database = await this.database;
      final maps = await database.rawQuery('''
      SELECT s.id, s.title, s.albumId
      FROM $_songTable AS s
      INNER JOIN $_albumTable AS a ON s.albumId = a.id
      WHERE a.artistId = ?
    ''', [artistId]);

      final result = List.generate(maps.length, (i) => Song.fromMap(maps[i]));

      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }
}
