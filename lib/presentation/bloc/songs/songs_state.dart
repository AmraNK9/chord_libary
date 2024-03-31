import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/domain/enties/song_entity.dart';

class SongState {
  final CrudState state;
  final List<SongEntity> songs;
  final Failure? failure;
  const SongState({required this.state, required this.songs, this.failure});

  SongState copyWith(
      {CrudState? state, List<SongEntity>? songs, Failure? failure}) {
    return SongState(
        state: state ?? this.state,
        songs: songs ?? this.songs,
        failure: failure ?? this.failure);
  }
}
