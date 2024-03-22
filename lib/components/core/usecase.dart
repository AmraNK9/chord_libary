import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';

class GeneralUseCase {}

class ImageUsecase {
  static saveNetworkImage(String image, String folderName) async {
    await Gal.hasAccess();
    await Gal.requestAccess(toAlbum: true);
    Directory? v77Folder = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      v77Folder = Directory('/storage/emulated/0/Pictures/$folderName');
    }
    if (!await v77Folder.exists()) {
      await v77Folder.create();
    }

    String savePath =
        "${v77Folder.path}/${DateTime.now().microsecondsSinceEpoch}.png";

    try {
      await Dio().download(image, savePath);

      await Gal.putImage(savePath, album: v77Folder.path);
    } catch (e) {
      rethrow;
    }
  }
}
