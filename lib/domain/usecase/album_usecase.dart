import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class AlbumHandler {
  final NgatRepositoryImpl ngatRepositoryImpl;

  AlbumHandler({required this.ngatRepositoryImpl});
  Future<Either<Failure, List<Album>>> get() async {
    return await ngatRepositoryImpl.getAlbums();
  }

  Future<Either<Failure, int>> create(Album album) async {
    return await ngatRepositoryImpl.insertAlbum(album);
  }
}
