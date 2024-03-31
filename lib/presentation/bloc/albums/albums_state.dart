part of 'albums_cubit.dart';

final class AlbumCrudState {
  final CrudState state;
  final List<AlbumEntity> albums;
  final String? error;

  AlbumCrudState({required this.state, required this.albums, this.error});

  AlbumCrudState copyWith(
      {CrudState? state, List<AlbumEntity>? albums, String? error}) {
    return AlbumCrudState(
        state: state ?? this.state,
        albums: albums ?? this.albums,
        error: error ?? this.error);
  }
}
