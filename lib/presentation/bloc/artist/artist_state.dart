part of 'artist_cubit.dart';

class ArtistState {
  final CrudState state;
  final List<ArtistEntity> artists;
  final Failure? failure;
  const ArtistState({required this.state, required this.artists, this.failure});

  ArtistState copyWith(
      {CrudState? state, List<ArtistEntity>? artists, Failure? failure}) {
    return ArtistState(
        state: state ?? this.state,
        artists: artists ?? this.artists,
        failure: failure ?? this.failure);
  }
}
