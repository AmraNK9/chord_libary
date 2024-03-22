// ignore: must_be_immutable
import 'package:chord_libary/components/core/mapKey.dart';
import 'package:chord_libary/components/core/usecase.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

enum PhotoMenu {
  save,
  report,
  delete,
  makeProfile,
}

class _ImageViewState extends State<ImageView> {
  bool isInit = true;
  List<String> images = [];
  int initialIndex = 0;
  final imageController = PhotoViewController();
  final imageScaleController = PhotoViewScaleStateController();

  bool isSwiperScrollable = true;

  late Map<String, dynamic> data;

  List<PopupMenuEntry<dynamic>> Menu = [
    const PopupMenuItem(
      value: PhotoMenu.save,
      child: Text('Save to device'),
    ),
  ];

  @override
  void didChangeDependencies() {
    if (isInit) {
      data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      images = data[MapKey.images];
      initialIndex = data[MapKey.initialImage] ?? 0;
      isInit = false;
    }
    imageScaleController.addIgnorableListener(() {
      print('is zooming - ${imageController.scale}');
      // if (imageScaleController.scaleState.isScaleStateZooming) {
      if ((imageController.scale ?? 0) < (imageController.initial.scale ?? 1)) {
        print('zooming true');
        // isSwiperScrollable = false;
        setState(() {
          isSwiperScrollable = false;
        });
      } else {
        setState(() {
          isSwiperScrollable = true;
        });
      }
    });

    imageController.addIgnorableListener(() {
      print('image scale ${imageController.scale}');

      if ((imageController.scale ?? 0) >
          (imageController.initial.scale ?? 0.2)) {
        setState(() {
          isSwiperScrollable = false;
        });
      } else {
        setState(() {
          isSwiperScrollable = true;
        });
      }
    });
    super.didChangeDependencies();
  }

  void photoMenuOnChange(dynamic value) {
    if (value == PhotoMenu.save) {
      String savingImage = images[initialIndex];
      ImageUsecase.saveNetworkImage(savingImage, "Chord_libery");
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build widget $isSwiperScrollable');
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              onSelected: photoMenuOnChange,
              itemBuilder: (context) {
                return Menu;
              })
        ],
      ),
      body: PhotoViewGallery.builder(
          pageController: PageController(initialPage: initialIndex),
          onPageChanged: (index) {
            initialIndex = index;
          },
          itemCount: images.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index]),
            );
          }),
    );
  }
}
