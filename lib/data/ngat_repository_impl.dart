import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/datasource/local_datasource.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/domain/nga_repository.dart';
import 'package:either_dart/src/either.dart';

class NgatRepositoryImpl implements NgatRepository {
  final LocalDataSource localDataSource;
  NgatRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<Album>>> getAlbums({Artist? artist}) async {
    // TODO: implement getAlbums
    try {
      if (artist != null) {}
      final failureOrAlbum = await localDataSource.getAlbums();
      return failureOrAlbum;
    } catch (e) {
      return Left(LocalFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Artist>>> getArtists(
      {Song? song, Album? album}) async {
    if (song != null) {
      return Left(LocalFailure(error: 'not get by song'));
    }
    return await localDataSource.getArtists();
  }

  @override
  Future<Either<Failure, List<Song>>> getSongs(
      {Artist? artist, Album? album}) async {
    // TODO: implement getSongs
    return await localDataSource.getSongs();
  }

  @override
  Future<Either<Failure, int>> insertAlbum(Album album) async {
    // TODO: implement insertAlbum
    return await localDataSource.insertAlbum(album);
  }

  @override
  Future<Either<Failure, int>> insertArtist(Artist artist) async {
    return await localDataSource.insertArtist(artist);
  }

  @override
  Future<Either<Failure, int>> insertSong(Song song) async {
    // TODO: implement insertSong
    return await localDataSource.insertSong(song);
  }
}
