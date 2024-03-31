import 'package:chord_libary/components/screen/retry_screen.dart';
import 'package:chord_libary/core/enum/enum_collection.dart';
import 'package:chord_libary/helper/album_helper.dart';
import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/components/widgets/header.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  late AlbumHelper albumHelper;
  late AlbumsCubit albumsCubit;

  @override
  Widget build(BuildContext context) {
    albumsCubit = context.read<AlbumsCubit>()..getAlbums();
    albumHelper = AlbumHelper(albumsCubit: albumsCubit);
    return Column(
      children: [
        const Header(
          title: "Albums",
        ),
        Expanded(
          child: BlocConsumer<AlbumsCubit, AlbumCrudState>(
            listener: (context, state) {
              if (state.state == CrudState.deleteFail) {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Dialog(
                        child: Text(state.error ?? 'unknownError'),
                      );
                    });
              }
            },
            builder: (context, state) {
              if (state.state == CrudState.fetchFail) {
                return Retry(onTap: () {});
              } else if (state.albums.isEmpty) {
                return Column(
                  children: [
                    Icon(
                      Icons.album,
                      size: 200,
                      color: AppColors.activeNavigationBarColor,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("No Albums Yet!"),
                    TextButton(
                        onPressed: () {
                          albumHelper.createAlbum(context);
                        },
                        child: const Text("Create Now"))
                  ],
                );
              }

              return ListView.builder(
                  itemCount: state.albums.length,
                  itemBuilder: (context, index) {
                    final album = state.albums[index];
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        SlidableAction(
                            icon: FontAwesomeIcons.deleteLeft,
                            onPressed: (_) {
                              albumHelper.deleteAlbum(context, album.toModal());
                            })
                      ]),
                      child: ListTile(
                        title: Text(album.title),
                      ),
                    );
                  });
            },
          ),
        )
      ],
    );
  }
}
