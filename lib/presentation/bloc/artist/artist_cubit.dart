import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/usecase/artist_usecase.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  final ArtistHandler artistHandler;
  ArtistCubit({required this.artistHandler})
      : super(
          const ArtistInitial(state: CrudState.initial),
        );
  void createAtist(Artist artist) async {
    emit(const ArtistCreating(state: CrudState.creating));
    final result = await artistHandler.create(artist);
    result.fold((left) => emit(const ArtistCreateFail()),
        (right) => emit(const ArtistCreteSuccess()));
    emit(const ArtistCreteSuccess());
  }

  void getArtist() async {
    emit(const FetchingArtist());
    final failOrArtist = await artistHandler.get();
    failOrArtist.fold((left) => emit(const FetchArtistFail()),
        (right) => emit(FetchArtistSuccess(artists: right)));
  }
}
