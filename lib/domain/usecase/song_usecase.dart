import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class SongHandler {
  final NgatRepositoryImpl ngatRepositoryImpl;

  SongHandler({required this.ngatRepositoryImpl});
  Future<Either<Failure, List<Song>>> get() async {
    return await ngatRepositoryImpl.getSongs();
  }

  Future<Either<Failure, int>> create(Song song) async {
    return await ngatRepositoryImpl.insertSong(song);
  }
}
