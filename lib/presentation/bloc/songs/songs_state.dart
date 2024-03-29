import 'package:chord_libary/core/failure.dart';
import 'package:chord_libary/data/model/z_models.dart';

sealed class SongsState {
  final CrudState state;
  const SongsState({required this.state});
}

final class SongsInitial extends SongsState {
  const SongsInitial({required super.state});
}

final class SongsCreating extends SongsState {
  const SongsCreating({super.state = CrudState.creating});
}

final class SongsCreteSuccess extends SongsState {
  const SongsCreteSuccess({super.state = CrudState.createSuccess});
}

final class SongsCreateFail extends SongsState {
  final Failure failure;
  const SongsCreateFail(
      {super.state = CrudState.createFail, required this.failure});
}

final class FetchingSongs extends SongsState {
  const FetchingSongs({super.state = CrudState.fetching});
}

final class FetchSongsSuccess extends SongsState {
  final List<Song> songs;
  const FetchSongsSuccess(
      {super.state = CrudState.fetchSuccess, required this.songs});
}

final class FetchSongsFail extends SongsState {
  final Failure failure;
  const FetchSongsFail(
      {super.state = CrudState.fetchFail, required this.failure});
}

enum CrudState {
  initial,
  creating,
  createSuccess,
  createFail,
  fetching,
  fetchSuccess,
  fetchFail,
  updating,
  updateSuccess,
  updateFail,
  deleting,
  deleteSuccess,
  deleteFail,
}
