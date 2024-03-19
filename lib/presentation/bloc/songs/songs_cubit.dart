import 'package:bloc/bloc.dart';
import 'package:chord_libary/data/model/models.dart';
import 'package:chord_libary/domain/usecase/song_usecase.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';

class SongsCubit extends Cubit<SongsState> {
  final SongHandler songHandler;
  SongsCubit({required this.songHandler})
      : super(
          const SongsInitial(state: CrudState.initial),
        );

  void getSongs() async {
    emit(const FetchingSongs());
    final filureOrSongs = await songHandler.get();
    filureOrSongs.fold((left) => emit(FetchSongsFail(failure: left)),
        (right) => emit(FetchSongsSuccess(songs: right)));
  }

  void createSong(Song song) async {
    emit(const SongsCreating());

    (await songHandler.create(song)).fold(
        (left) => emit(SongsCreateFail(failure: left)),
        (right) => emit(const SongsCreteSuccess()));
  }
}
