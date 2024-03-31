import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/enties/album_entity.dart';
import 'package:chord_libary/domain/enties/artist_entity.dart';
import 'package:chord_libary/domain/enties/song_entity.dart';
import 'package:either_dart/either.dart';

abstract class NgatRepository {
  NgatRepository();

  // Artist Functions
  Future<Either<Failure, int>> insertArtist(Artist artist);

  Future<Either<Failure, List<ArtistEntity>>> getArtists();

  Future<Either<Failure, int>> deleteArtist(Artist artist);

  // Album Functions
  Future<Either<Failure, int>> insertAlbum(Album album);

  Future<Either<Failure, List<AlbumEntity>>> getAlbums({Artist? artist});

  Future<Either<Failure, int>> deleteAlbum(Album album);

  // Future<Either<Failure, List<Album>>> getAlbumsByArtist(int artistId);

  // Future<Either<Failure, List<Album>>> fetch({int? artistId, int? id});

  // Song Functions
  Future<Either<Failure, int>> insertSong(Song song);

  Future<Either<Failure, List<SongEntity>>> getSongs(
      {Artist? artist, Album? album});

  Future<Either<Failure, int>> deleteSong(Song song);

  // Future<Either<Failure, List<Song>>> getSongsByArtist(int artistId);

  // Future<Either<Failure, List<Song>>> getSongsByAlbum(int albumId);
}
