import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class ArtistHandler {
  final NgatRepositoryImpl ngatRepositoryImpl;

  ArtistHandler({required this.ngatRepositoryImpl});
  Future<Either<Failure, List<Artist>>> get() async {
    return await ngatRepositoryImpl.getArtists();
  }

  Future<Either<Failure, int>> create(Artist artist) async {
    return await ngatRepositoryImpl.insertArtist(artist);
  }
}
