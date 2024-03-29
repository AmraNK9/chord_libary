import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/helper/artist_helper.dart';
import 'package:chord_libary/components/widgets/header.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  final ArtistHelper artistHelper = getIt<ArtistHelper>();
  @override
  Widget build(BuildContext context) {
    context.read<ArtistCubit>().getArtist();
    return Column(
      children: [
        const Header(
          title: "Artists",
        ),
        Expanded(
          child: BlocBuilder<ArtistCubit, ArtistState>(
            builder: (context, state) {
              if (state is FetchArtistSuccess) {
                return ListView.builder(
                    itemCount: state.artists.length,
                    itemBuilder: (context, index) {
                      final artist = state.artists[index];
                      return ListTile(
                        title: Text(artist.name),
                      );
                    });
              }
              return Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 200,
                    color: AppColors.activeNavigationBarColor,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text("No Artist Yet!"),
                  TextButton(
                      onPressed: () {
                        artistHelper.createArtist(context);
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
