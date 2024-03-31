import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';
import 'package:chord_libary/domain/enties/album_entity.dart';
import 'package:chord_libary/domain/usecase/album_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'albums_state.dart';

class AlbumsCubit extends Cubit<AlbumCrudState> {
  final AlbumHandler albumHandler;
  AlbumsCubit({required this.albumHandler})
      : super(
          AlbumCrudState(state: CrudState.initial, albums: []),
        );
  void createAlbum(Album album) async {
    emit(state.copyWith(state: CrudState.creating));
    final result = await albumHandler.create(album);

    result.fold((left) => emit(state.copyWith(state: CrudState.createFail)),
        (right) {
      state.albums.add(album.toEntity());
      emit(state.copyWith(state: CrudState.createSuccess));
    });
  }

  void getAlbums() async {
    emit(state.copyWith(state: CrudState.fetching));
    final failOrAlbums = await albumHandler.get();
    failOrAlbums.fold(
        (left) => emit(state.copyWith(
            state: CrudState.fetchFail, error: (left as LocalFailure).error)),
        (right) =>
            emit(state.copyWith(state: CrudState.fetchSuccess, albums: right)));
  }

  void deleteAlbum(Album album) async {
    emit(state.copyWith(state: CrudState.fetching));

    final failOrId = await albumHandler.delete(album);

    failOrId.fold(
        (left) => emit(state.copyWith(
            state: CrudState.deleteFail,
            error: (left as LocalFailure).error)), (right) {
      List<AlbumEntity> temp = state.albums;

      debugPrint("_____db_return_id_____$right");
      debugPrint("______Temp $temp");

      temp.removeWhere((element) => element.id == album.id);
      debugPrint("_______Deleted_Temp $temp");
      debugPrint('____Delete_Success_in_Bloc_____');
      emit(state.copyWith(
        albums: temp,
        state: CrudState.deleteSuccess,
      ));
    });
  }
}
