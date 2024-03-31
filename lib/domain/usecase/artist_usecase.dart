import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/data/repository/ngat_repository_impl.dart';
import 'package:chord_libary/domain/enties/artist_entity.dart';
import 'package:either_dart/either.dart';

class ArtistHandler {
  final NgatRepositoryImpl ngatRepository;

  ArtistHandler({required this.ngatRepository});
  Future<Either<Failure, List<ArtistEntity>>> get() async {
    return await ngatRepository.getArtists();
  }

  Future<Either<Failure, int>> create(Artist artist) async {
    return await ngatRepository.insertArtist(artist);
  }

  Future<Either<Failure, int>> delete(Artist artist) async {
    return await ngatRepository.deleteArtist(artist);
  }
}
