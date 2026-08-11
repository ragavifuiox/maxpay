import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/downlaod_usecase.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';

class DownloadController extends GetxController {
  final DownloadUsecase downloadUseCase;

  DownloadController({required this.downloadUseCase});

  final Dio dio = Dio();

  RxBool isDownloading = false.obs;

  Future<void> downloadReceipt(String rechargeId) async {
    try {
      print("========== DOWNLOAD START ==========");
      print("Recharge ID : $rechargeId");

      isDownloading.value = true;

      final result = await downloadUseCase(successid: rechargeId);

      await result.fold(
        (failure) async {
          print("API FAILED");
          print("Message : ${failure.message}");
          CustomToast.error(failure.message);
        },
        (download) async {
          print("API SUCCESS");

          final receiptUrl = download.code?.receiptUrl ?? "";

          print("Receipt URL : $receiptUrl");

          if (receiptUrl.isEmpty) {
            print("Receipt URL is Empty");
            CustomToast.error("Receipt URL not found");
            return;
          }

          /// Download folder
          final directory = Directory("/storage/emulated/0/Download");

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }

          final savePath = "${directory.path}/Receipt_$rechargeId.pdf";

          print("Save Path : $savePath");

          /// Get response as bytes
          final response = await dio.get(
            receiptUrl,
            options: Options(responseType: ResponseType.bytes),
          );

          print("Status Code : ${response.statusCode}");
          final contentType = response.headers.value('content-type') ?? "";
          print("Content-Type : $contentType");
          print("Headers : ${response.headers.map}");

          final bytes = response.data as List<int>;

          print("First 20 Bytes : ${bytes.take(20).toList()}");

          List<int> finalBytes = bytes;

          bool isImage = false;
          if (bytes.length > 4) {
            // Check magic bytes for JPEG (FF D8) or PNG (89 50 4E 47)
            if (bytes[0] == 0xFF && bytes[1] == 0xD8) {
              isImage = true;
            } else if (bytes[0] == 0x89 &&
                bytes[1] == 0x50 &&
                bytes[2] == 0x4E &&
                bytes[3] == 0x47) {
              isImage = true;
            }
          }

          // Check if response is an image, if so, convert to PDF
          if (contentType.toLowerCase().contains("image") || isImage) {
            print("Image detected. Converting to PDF...");
            try {
              final pdf = pw.Document();
              final image = pw.MemoryImage(Uint8List.fromList(bytes));

              pdf.addPage(
                pw.Page(
                  pageFormat: PdfPageFormat.a4,
                  build: (pw.Context context) {
                    return pw.Center(child: pw.Image(image));
                  },
                ),
              );
              finalBytes = await pdf.save();
            } catch (e) {
              print("Failed to convert image to PDF: $e");
              CustomToast.error("Failed to process receipt image");
              return;
            }
          } else if (bytes.length > 4 && bytes[0] != 0x25 && bytes[1] != 0x50) {
            // If it's not an image, and doesn't start with %PDF (25 50 44 46)
            print(
              "Warning: Downloaded file may not be a valid PDF or Image. Starts with: ${bytes.take(4).toList()}",
            );
          }

          /// Save file
          final file = File(savePath);

          await file.writeAsBytes(finalBytes);

          print("File Exists : ${await file.exists()}");
          print("File Size : ${await file.length()} bytes");

          print("========== DOWNLOAD COMPLETED ==========");

          CustomToast.success("Receipt saved in Downloads");

          // Automatically open the downloaded file
          final openResult = await OpenFile.open(savePath);
          print("OpenFile Result: ${openResult.type} - ${openResult.message}");
        },
      );
    } catch (e, s) {
      print("DOWNLOAD ERROR");
      print(e);
      print(s);

      CustomToast.error(e.toString());
    } finally {
      isDownloading.value = false;
      print("========== DOWNLOAD END ==========");
    }
  }
}
