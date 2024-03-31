import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/data/repository/ngat_repository_impl.dart';
import 'package:chord_libary/domain/enties/album_entity.dart';
import 'package:either_dart/either.dart';

class AlbumHandler {
  final NgatRepositoryImpl ngatRepository;

  AlbumHandler({required this.ngatRepository});
  Future<Either<Failure, List<AlbumEntity>>> get() async {
    return await ngatRepository.getAlbums();
  }

  Future<Either<Failure, int>> create(Album album) async {
    return await ngatRepository.insertAlbum(album);
  }

  Future<Either<Failure, int>> delete(Album album) async {
    return await ngatRepository.deleteAlbum(album);
  }
}
