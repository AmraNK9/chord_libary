part of 'albums_cubit.dart';

@immutable
sealed class AlbumsState {
  final CrudState state;
  const AlbumsState({required this.state});
}

final class AlbumsInitial extends AlbumsState {
  const AlbumsInitial({super.state = CrudState.initial});
}

final class AlbumsCreating extends AlbumsState {
  const AlbumsCreating({super.state = CrudState.creating});
}

final class AlbumsCreteSuccess extends AlbumsState {
  const AlbumsCreteSuccess({super.state = CrudState.createSuccess});
}

final class AlbumsCreateFail extends AlbumsState {
  const AlbumsCreateFail({super.state = CrudState.createFail});
}

final class FetchingAlbums extends AlbumsState {
  const FetchingAlbums({super.state = CrudState.fetching});
}

final class FetchAlbumsSuccess extends AlbumsState {
  final List<Album> Albumss;
  const FetchAlbumsSuccess(
      {super.state = CrudState.fetchSuccess, required this.Albumss});
}

final class FetchAlbumsFail extends AlbumsState {
  const FetchAlbumsFail({super.state = CrudState.fetchFail});
}
