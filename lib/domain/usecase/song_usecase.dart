import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:either_dart/either.dart';

class SongHandler {
  final NgatRepositoryImpl ngatRepository;

  SongHandler({required this.ngatRepository});
  Future<Either<Failure, List<Song>>> get() async {
    return await ngatRepository.getSongs();
  }

  Future<Either<Failure, int>> create(Song song) async {
    return await ngatRepository.insertSong(song);
  }
}
