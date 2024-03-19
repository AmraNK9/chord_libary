import 'package:chord_libary/core/theme.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:chord_libary/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  init();
  runApp(const MusicLibery());
}

class MusicLibery extends StatelessWidget {
  const MusicLibery({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.get(isLight: true),
      darkTheme: AppTheme.get(isLight: false),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<ArtistCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SongsCubit>(),
          ),
          BlocProvider(create: (context) => getIt<AlbumsCubit>())
        ],
        child: const Home(
          title: 'Chord Libery',
        ),
      ),
    );
  }
}
