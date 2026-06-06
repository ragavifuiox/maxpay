




import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_store_plus/media_store_plus.dart';

Future<void> downloadPdf(
  String url,
  String fileName,
  BuildContext context,
) async {
  try {

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200 && response.data != null) {

      final tempDir = await getTemporaryDirectory();

      final file = File("${tempDir.path}/$fileName.pdf");

      await file.writeAsBytes(response.data);

      final mediaStore = MediaStore();

      await mediaStore.saveFile(
        tempFilePath: file.path,
        dirType: DirType.download,
        dirName: DirName.download,
      );

      // CLOSE LOADER
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
  CustomToast.success("PDF downloaded successfully");
      // SUCCESS MESSAGE
      

    } else {

      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
  CustomToast.error("Failed to download PDF");
         
    }

  } catch (e) {

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
   
    AppLogger.debugPrint(e);
 CustomToast.error("An error occurred while downloading PDF");
    
  }
}