import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class AlbumHandler {
  final NgatRepositoryImpl ngatRepository;

  AlbumHandler({required this.ngatRepository});
  Future<Either<Failure, List<Album>>> get() async {
    return await ngatRepository.getAlbums();
  }

  Future<Either<Failure, int>> create(Album album) async {
    return await ngatRepository.insertAlbum(album);
  }
}
