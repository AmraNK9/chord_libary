import 'package:chord_libary/components/dialogs/create_song_dialog.dart';
import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/components/widgets/header.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    context.read<SongsCubit>().getSongs();
    return Column(
      children: [
        const Header(
          title: "Songs",
        ),
        Expanded(
          child: BlocBuilder<SongsCubit, SongsState>(
            builder: (context, state) {
              if (state is FetchSongsSuccess) {
                return ListView.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      final song = state.songs[index];
                      return ListTile(
                        title: Text(song.title),
                      );
                    });
              }
              print(state);
              return Column(
                children: [
                  Icon(
                    Icons.queue_music,
                    size: 200,
                    color: AppColors.activeNavigationBarColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("No Song Yet!"),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => getIt<SongsCubit>(),
                                    ),
                                    BlocProvider(
                                      create: (context) => getIt<AlbumsCubit>(),
                                    ),
                                  ],
                                  child: CreateSongDialog(),
                                ));
                      },
                      child: const Text("Create Now"))
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
