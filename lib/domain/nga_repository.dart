import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:either_dart/either.dart';

abstract class NgatRepository {
  NgatRepository();

  // Artist Functions
  Future<Either<Failure, int>> insertArtist(Artist artist);

  Future<Either<Failure, List<Artist>>> getArtists();

  // Album Functions
  Future<Either<Failure, int>> insertAlbum(Album album);

  Future<Either<Failure, List<Album>>> getAlbums({Artist? artist});

  // Future<Either<Failure, List<Album>>> getAlbumsByArtist(int artistId);

  // Future<Either<Failure, List<Album>>> fetch({int? artistId, int? id});

  // Song Functions
  Future<Either<Failure, int>> insertSong(Song song);

  Future<Either<Failure, List<Song>>> getSongs({Artist? artist, Album? album});

  // Future<Either<Failure, List<Song>>> getSongsByArtist(int artistId);

  // Future<Either<Failure, List<Song>>> getSongsByAlbum(int albumId);
}
