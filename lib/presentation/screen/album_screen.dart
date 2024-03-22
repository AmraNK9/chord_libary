import 'package:chord_libary/helper/artist_helper.dart';
import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/components/widgets/header.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  final AlbumHelper albumHelper = getIt<AlbumHelper>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          title: "Albumss",
        ),
        Expanded(
          child: BlocBuilder<AlbumsCubit, AlbumsState>(
            builder: (context, state) {
              if (state is FetchAlbumsSuccess && state.Albumss.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.Albumss.length,
                    itemBuilder: (context, index) {
                      final albums = state.Albumss[index];
                      return ListTile(
                        title: Text(albums.title),
                      );
                    });
              }
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
            },
          ),
        )
      ],
    );
  }
}
