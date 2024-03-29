import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class ArtistHandler {
  final NgatRepositoryImpl ngatRepository;

  ArtistHandler({required this.ngatRepository});
  Future<Either<Failure, List<Artist>>> get() async {
    return await ngatRepository.getArtists();
  }

  Future<Either<Failure, int>> create(Artist artist) async {
    return await ngatRepository.insertArtist(artist);
  }
}
