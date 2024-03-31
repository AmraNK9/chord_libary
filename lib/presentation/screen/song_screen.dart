import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/components/widgets/header.dart';
import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/helper/song_helper.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final SongHelper songHelper = getIt<SongHelper>();
  @override
  Widget build(BuildContext context) {
    context.read<SongsCubit>().getSongs();
    return Column(
      children: [
        const Header(
          title: "Songs",
        ),
        Expanded(
          child: BlocBuilder<SongsCubit, SongState>(
            builder: (context, state) {
              if (state.state == CrudState.fetchSuccess) {
                return ListView.builder(
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      final song = state.songs[index];
                      return Slidable(
                        endActionPane:
                            ActionPane(motion: const ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (_) {
                              songHelper.deleteSong(context, song.toModel());
                            },
                            icon: FontAwesomeIcons.deleteLeft,
                          )
                        ]),
                        child: ListTile(
                          title: Text(song.title),
                        ),
                      );
                    });
              }
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
                        songHelper.createSong(context);
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
