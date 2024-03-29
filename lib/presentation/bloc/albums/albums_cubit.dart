import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/usecase/album_usecase.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumsState> {
  final AlbumHandler albumHandler;
  AlbumsCubit({required this.albumHandler})
      : super(
          const AlbumsInitial(state: CrudState.initial),
        );
  void createAlbum(Album album) async {
    emit(const AlbumsCreating(state: CrudState.creating));
    final result = await albumHandler.create(album);
    result.fold((left) => emit(const AlbumsCreateFail()),
        (right) => emit(const AlbumsCreteSuccess()));
    emit(const AlbumsCreteSuccess());
  }

  void getAlbums() async {
    emit(const FetchingAlbums());
    final failOrAlbums = await albumHandler.get();
    failOrAlbums.fold((left) => emit(const FetchAlbumsFail()),
        (right) => emit(FetchAlbumsSuccess(albums: right)));
  }
}
