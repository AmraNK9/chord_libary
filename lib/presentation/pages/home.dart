import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:chord_libary/presentation/widgets/create_album_dialog.dart';
import 'package:chord_libary/presentation/widgets/create_artist_dialog.dart';
import 'package:chord_libary/presentation/widgets/create_song_dialog.dart';
import 'package:chord_libary/core/constants.dart';
import 'package:chord_libary/core/theme.dart';
import 'package:chord_libary/injection_container.dart';
import 'package:chord_libary/presentation/bloc/albums/albums_cubit.dart';
import 'package:chord_libary/presentation/bloc/artist/artist_cubit.dart';
import 'package:chord_libary/presentation/bloc/songs/songs_cubit.dart';
import 'package:chord_libary/presentation/screen/album_screen.dart';
import 'package:chord_libary/presentation/screen/artist_screen.dart';
import 'package:chord_libary/presentation/screen/song_screen.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.person,
    Icons.album,
    Icons.queue_music,
    Icons.access_time,
  ];

  get labelList => ['Artist', "Album", "Songs", "Recent"];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            )
          ],
          backgroundColor: Colors.black,
          title: Row(
            children: [
              const Icon(
                FontAwesomeIcons.guitar,
                color: Colors.white,
              ),
              Text(
                "Ngat",
                style: GoogleFonts.pacifico(color: Colors.white),
              )
            ],
          )),
      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: NavigationScreen(iconList[_bottomNavIndex]),
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        shape: const CircleBorder(),
        backgroundColor: AppColors.floatingActionButton,
        child: Icon(
          Icons.add,
          color: AppTheme.colorGray,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => FluidDialog(
              // Set the first page of the dialog.
              rootPage: FluidDialogPage(
                alignment:
                    Alignment.center, //Aligns the dialog to the bottom left.

                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        DialogNavigator.of(context)
                            .push(FluidDialogPage(builder: (context) {
                          return BlocProvider(
                            create: (context) => getIt<ArtistCubit>(),
                            child: CreateArtistDialog(),
                          );
                        }));
                      },
                      title: const Text("Create New Artist"),
                    ),
                    ListTile(
                      onTap: () {
                        DialogNavigator.of(context)
                            .push(FluidDialogPage(builder: (context) {
                          return MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (context) => getIt<AlbumsCubit>(),
                              ),
                              BlocProvider(
                                create: (context) =>
                                    getIt<ArtistCubit>()..getArtist(),
                              ),
                            ],
                            child: BlocBuilder<ArtistCubit, ArtistState>(
                              builder: (context, state) {
                                if (state is FetchArtistSuccess) {
                                  return CreateAlbumDialog(
                                    artists: state.artists,
                                  );
                                }
                                return const Center(
                                  child: Text('Loading'),
                                );
                              },
                            ),
                          );
                        }));
                      },
                      title: const Text("Create New Song"),
                    ),
                    ListTile(
                      onTap: () {
                        DialogNavigator.of(context)
                            .push(FluidDialogPage(builder: (context) {
                          return BlocProvider(
                            create: (context) => getIt<SongsCubit>(),
                            child: CreateSongDialog(),
                          );
                        }));
                      },
                      title: const Text("Create New Song"),
                    )
                  ],
                ), // This can be any widget.
              ),
            ),
          );
          // _fabAnimationController.reset();
          // _borderRadiusAnimationController.reset();
          // _borderRadiusAnimationController.forward();
          // _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? AppColors.activeNavigationBarColor
              : AppColors.notActiveNavigationBarColor;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  labelList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: AppColors.bottomNavigationBarBackgroundColor,
        activeIndex: _bottomNavIndex,
        splashColor: AppColors.bottomNavigationSplashColor,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: const Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: AppColors.bottomNavigationShadowColor,
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen(this.iconData, {super.key});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CircularRevealAnimation(
        animation: animation,
        centerOffset: const Offset(80, 80),
        maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
        child: Builder(builder: (context) {
          if (widget.iconData == Icons.person) {
            return const ArtistPage();
          }
          if (widget.iconData == Icons.album) {
            return const AlbumsPage();
          }
          if (widget.iconData == Icons.queue_music) {
            return const SongPage();
          }
          return Center(
            child: Icon(
              widget.iconData,
              color: AppColors.activeNavigationBarColor,
              size: 160,
            ),
          );
        }),
      ),
    );
  }
}
