import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/usecase/song_usecase.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongsCubit extends Cubit<SongState> {
  final SongHandler songHandler;
  SongsCubit({required this.songHandler})
      : super(
          const SongState(state: CrudState.initial, songs: []),
        );

  void getSongs() async {
    emit(state.copyWith(state: CrudState.fetching));
    final filureOrSongs = await songHandler.get();
    filureOrSongs.fold(
        (left) =>
            emit(state.copyWith(state: CrudState.fetching, failure: left)),
        (right) =>
            emit(state.copyWith(state: CrudState.fetchSuccess, songs: right)));
  }

  void createSong(Song song) async {
    emit(state.copyWith(state: CrudState.creating));

    (await songHandler.create(song)).fold(
        (left) =>
            emit(state.copyWith(failure: left, state: CrudState.createFail)),
        (right) => emit(state.copyWith(state: CrudState.fetchSuccess)));
  }

  void deleteSong(Song song) async {
    emit(state.copyWith(state: CrudState.deleting));
  }
}
