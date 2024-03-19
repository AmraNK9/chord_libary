part of 'artist_cubit.dart';

@immutable
sealed class ArtistState {
  final CrudState state;
  const ArtistState({required this.state});
}

final class ArtistInitial extends ArtistState {
  const ArtistInitial({required super.state});
}

final class ArtistCreating extends ArtistState {
  const ArtistCreating({super.state = CrudState.creating});
}

final class ArtistCreteSuccess extends ArtistState {
  const ArtistCreteSuccess({super.state = CrudState.createSuccess});
}

final class ArtistCreateFail extends ArtistState {
  const ArtistCreateFail({super.state = CrudState.createFail});
}

final class FetchingArtist extends ArtistState {
  const FetchingArtist({super.state = CrudState.fetching});
}

final class FetchArtistSuccess extends ArtistState {
  final List<Artist> artists;
  const FetchArtistSuccess(
      {super.state = CrudState.fetchSuccess, required this.artists});
}

final class FetchArtistFail extends ArtistState {
  const FetchArtistFail({super.state = CrudState.fetchFail});
}
