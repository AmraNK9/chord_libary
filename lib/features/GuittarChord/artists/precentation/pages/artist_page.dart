import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/core/dialogs/create_artist_dialog.dart';
import 'package:chord_libary/core/widgets/header.dart';
import 'package:flutter/material.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({super.key});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          title: "Artists",
        ),
        Expanded(
          child: Column(
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
                    showDialog(
                        context: context,
                        builder: (context) => const CreateArtistDialog());
                  },
                  child: const Text("Create Now"))
            ],
          ),
        )
      ],
    );
  }
}
