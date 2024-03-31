import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/enties/artist_entity.dart';
import 'package:chord_libary/domain/usecase/artist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final ArtistHandler artistHandler;
  ArtistCubit({required this.artistHandler})
      : super(
          const ArtistState(state: CrudState.initial, artists: []),
        );
  void createAtist(Artist artist) async {
    emit(state.copyWith(state: CrudState.creating));
    final result = await artistHandler.create(artist);
    result.fold(
        (left) =>
            emit(state.copyWith(state: CrudState.createFail, failure: left)),
        (right) {
      state.artists.add(artist.toEntity());
      emit(state.copyWith(
        state: CrudState.createSuccess,
      ));
    });
  }

  void getArtist() async {
    emit(state.copyWith(state: CrudState.fetching));
    final failOrArtist = await artistHandler.get();
    failOrArtist.fold(
        (left) =>
            emit(state.copyWith(state: CrudState.fetchFail, failure: left)),
        (right) => emit(
            state.copyWith(state: CrudState.fetchSuccess, artists: right)));
  }
}
