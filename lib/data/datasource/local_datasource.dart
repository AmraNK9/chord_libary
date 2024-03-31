import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/enties/album_entity.dart';
import 'package:chord_libary/domain/enties/artist_entity.dart';
import 'package:chord_libary/domain/enties/song_entity.dart';
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

  Future<Either<Failure, int>> deleteArtist(Artist artist) async {
    try {
      final database = await this.database;
      final result = await database
          .delete(_artistTable, where: 'id=', whereArgs: [artist.id]);
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<ArtistEntity>>> getArtists() async {
    try {
      final database = await this.database;
      final maps = await database.query(_artistTable);
      final artistList =
          List.generate(maps.length, (i) => Artist.fromMap(maps[i]).toEntity());
      return Right(artistList);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, int>> deleteAlbum(Album album) async {
    try {
      final database = await this.database;
      final result = await database
          .delete(_albumTable, where: "id = ?", whereArgs: [album.id]);
      return Right(result);
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

  Future<Either<Failure, List<AlbumEntity>>> getAlbums() async {
    try {
      final database = await this.database;
      final maps = await database.query(_albumTable);
      final result =
          List.generate(maps.length, (i) => Album.fromMap(maps[i]).toEntity());
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<AlbumEntity>>> getAlbumsByArtist(
      int artistId) async {
    try {
      final database = await this.database;
      final maps = await database
          .query(_albumTable, where: 'artistId = ?', whereArgs: [artistId]);
      final result =
          List.generate(maps.length, (i) => Album.fromMap(maps[i]).toEntity());
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

  Future<Either<Failure, int>> deleteSong(Song song) async {
    try {
      final database = await this.database;
      final result =
          await database.delete(_songTable, where: 'id=', whereArgs: [song.id]);
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<SongEntity>>> getSongs() async {
    try {
      final database = await this.database;
      final maps = await database.query(_songTable);
      final result =
          List.generate(maps.length, (i) => Song.fromMap(maps[i]).toEntity());
      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<SongEntity>>> getSongsByAlbum(int albumId) async {
    try {
      final database = await this.database;
      final maps = await database
          .query(_songTable, where: 'albumId = ?', whereArgs: [albumId]);
      final result =
          List.generate(maps.length, (i) => Song.fromMap(maps[i]).toEntity());

      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<SongEntity>>> getSongsByArtist(
      int artistId) async {
    try {
      final database = await this.database;
      final maps = await database.rawQuery('''
      SELECT s.id, s.title, s.albumId
      FROM $_songTable AS s
      INNER JOIN $_albumTable AS a ON s.albumId = a.id
      WHERE a.artistId = ?
    ''', [artistId]);

      final result =
          List.generate(maps.length, (i) => Song.fromMap(maps[i]).toEntity());

      return Right(result);
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }
}
