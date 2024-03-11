import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'artist_state.dart';

class ArtistCubit extends Cubit<ArtistState> {
  ArtistCubit() : super(ArtistInitial());
  void createAtist() {}
}
