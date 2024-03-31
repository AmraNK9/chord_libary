import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/datasource/local_datasource.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/enties/album_entity.dart';
import 'package:chord_libary/domain/enties/artist_entity.dart';
import 'package:chord_libary/domain/enties/song_entity.dart';
import 'package:chord_libary/domain/nga_repository.dart';
import 'package:either_dart/either.dart';

class NgatRepositoryImpl implements NgatRepository {
  final LocalDataSource localDataSource;
  NgatRepositoryImpl({required this.localDataSource});
  //[Album]
  @override
  Future<Either<Failure, List<AlbumEntity>>> getAlbums({Artist? artist}) async {
    try {
      if (artist != null) {}
      final failureOrAlbum = await localDataSource.getAlbums();
      return failureOrAlbum;
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> insertAlbum(Album album) async {
    return await localDataSource.insertAlbum(album);
  }

  @override
  Future<Either<Failure, int>> deleteAlbum(Album album) async {
    return await localDataSource.deleteAlbum(album);
  }

//[Artist]
  @override
  Future<Either<Failure, List<ArtistEntity>>> getArtists(
      {Song? song, Album? album}) async {
    if (song != null) {
      return Left(LocalFailure(error: 'not get by song'));
    }
    return await localDataSource.getArtists();
  }

  @override
  Future<Either<Failure, int>> insertArtist(Artist artist) async {
    return await localDataSource.insertArtist(artist);
  }

  @override
  Future<Either<Failure, int>> deleteArtist(Artist artist) async {
    return await localDataSource.deleteArtist(artist);
  }

  //[Song]

  @override
  Future<Either<Failure, List<SongEntity>>> getSongs(
      {Artist? artist, Album? album}) async {
    return await localDataSource.getSongs();
  }

  @override
  Future<Either<Failure, int>> insertSong(Song song) async {
    return await localDataSource.insertSong(song);
  }

  @override
  Future<Either<Failure, int>> deleteSong(Song song) async {
    return await localDataSource.deleteSong(song);
  }
}
