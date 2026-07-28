import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareReceipt {

  static Future<void> sharePdf({
    required String pdfUrl,
    required String phone,
  }) async {

    try {

      final directory = await getTemporaryDirectory();

      final filePath =
          "${directory.path}/transaction_receipt.pdf";


      // Download PDF
      await Dio().download(
        pdfUrl,
        filePath,
      );


      final file = File(filePath);


      if (!await file.exists()) {
        print("PDF file not found");
        return;
      }


      print("PDF PATH : $filePath");
      print("SIZE : ${await file.length()}");


      await Share.shareXFiles(
        [
          XFile(
            file.path,
            mimeType: "application/pdf",
          ),
        ],
        text:
        "Transaction Receipt\nCustomer: $phone",
      );


    } catch(e) {

      print("SHARE ERROR : $e");

    }
  }
}