import 'package:chord_libary/data/datasource/local_datasource.dart';
import 'package:chord_libary/data/ngat_repository_impl.dart';
import 'package:chord_libary/domain/usecase/album_usecase.dart';
import 'package:chord_libary/domain/usecase/artist_usecase.dart';
import 'package:chord_libary/domain/usecase/song_usecase.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void init() {
  //Bloc
  getIt.registerFactory(() => ArtistCubit(artistHandler: getIt()));
  getIt.registerFactory(() => AlbumsCubit(albumHandler: getIt()));
  getIt.registerFactory(() => SongsCubit(songHandler: getIt()));
  //Use cases
  getIt.registerLazySingleton(() => ArtistHandler(ngatRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => AlbumHandler(ngatRepositoryImpl: getIt()));
  getIt.registerLazySingleton(() => SongHandler(ngatRepositoryImpl: getIt()));

  //Repositories
  getIt.registerLazySingleton(
      () => NgatRepositoryImpl(localDataSource: getIt()));

  //Data sources
  getIt.registerLazySingleton(() => LocalDataSource());
}
