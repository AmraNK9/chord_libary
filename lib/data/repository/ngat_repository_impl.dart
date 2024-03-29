import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/datasource/local_datasource.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/nga_repository.dart';
import 'package:either_dart/either.dart';

class NgatRepositoryImpl extends NgatRepository {
  final LocalDataSource localDataSource;
  NgatRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, List<Album>>> getAlbums({Artist? artist}) async {
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
    return await localDataSource.getSongs();
  }

  @override
  Future<Either<Failure, int>> insertAlbum(Album album) async {
    return await localDataSource.insertAlbum(album);
  }

  @override
  Future<Either<Failure, int>> insertArtist(Artist artist) async {
    return await localDataSource.insertArtist(artist);
  }

  @override
  Future<Either<Failure, int>> insertSong(Song song) async {
    return await localDataSource.insertSong(song);
  }
}
