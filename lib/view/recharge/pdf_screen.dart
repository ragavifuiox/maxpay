import 'dart:io';

import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> downloadReceipt(String receiptUrl, String rechargeId) async {
  // Request permission
  await Permission.storage.request();

  final dio = Dio();

  final dir = Directory("/storage/emulated/0/Download");

  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }

  final filePath = "${dir.path}/Receipt_$rechargeId.pdf";

  await dio.download(
    receiptUrl,
    filePath,
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );

  print("Saved : $filePath");
}