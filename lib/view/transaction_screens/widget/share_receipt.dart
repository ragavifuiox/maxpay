import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareReceipt {
  /// Downloads the PDF from [pdfUrl] and shares the actual file
  /// to WhatsApp (or the system share sheet as a fallback).
  static Future<void> sharePdf({
    required String pdfUrl,
    required String phone,
  }) async {
    try {
      // 1. Normalize phone number (WhatsApp needs country code, no symbols)
      String normalizedPhone = phone.replaceAll(RegExp(r'\D'), '');
      if (normalizedPhone.length == 10) {
        normalizedPhone = '91$normalizedPhone';
      }

      // 2. Download the PDF to a local temp file first.
      //    WhatsApp's whatsapp:// URL scheme can only prefill TEXT,
      //    it cannot attach a file. To actually send the file itself
      //    you must share a local file path via the OS share sheet.
      final filePath = await _downloadPdf(pdfUrl);

      if (filePath == null) {
        // Download failed — fall back to sending just the link.
        await _shareLinkFallback(pdfUrl, phone, normalizedPhone);
        return;
      }

      final xFile = XFile(filePath, mimeType: 'application/pdf');

      // 3. Share the actual PDF file.
      //    On Android you can target the WhatsApp app directly.
      //    On iOS, Apple does not allow deep-linking straight into a
      //    WhatsApp chat with a pre-attached file — the user must pick
      //    the WhatsApp contact from the native share sheet themselves.
      final result = await Share.shareXFiles(
        [xFile],
        text: 'Hello, here is your Transaction Receipt.',
        subject: 'Transaction Receipt',
      );

      if (result.status != ShareResultStatus.success) {
        // User cancelled or it failed — nothing more to do.
        print('Share dismissed or failed: ${result.status}');
      }
    } catch (e) {
      print('SHARE ERROR : $e');
      // Last-resort fallback: at least send the link.
      await _shareLinkFallback(pdfUrl, phone, phone.replaceAll(RegExp(r'\D'), ''));
    }
  }

  /// Downloads [pdfUrl] into the app's temp directory and
  /// returns the local file path, or null on failure.
  static Future<String?> _downloadPdf(String pdfUrl) async {
    try {
      final dir = await getTemporaryDirectory();
      final fileName = 'receipt_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final savePath = '${dir.path}/$fileName';

      final dio = Dio();
      final response = await dio.download(
        pdfUrl,
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      if (response.statusCode == 200) {
        final file = File(savePath);
        if (await file.exists() && await file.length() > 0) {
          return savePath;
        }
      }
      return null;
    } catch (e) {
      print('DOWNLOAD ERROR : $e');
      return null;
    }
  }

  /// Fallback: open WhatsApp chat with just the text/link,
  /// or use the generic share sheet if WhatsApp isn't available.
  static Future<void> _shareLinkFallback(
    String pdfUrl,
    String rawPhone,
    String normalizedPhone,
  ) async {
    final String message = 'Hello, here is your Transaction Receipt:\n$pdfUrl';
    final Uri whatsappUri = Uri.parse(
      'whatsapp://send?phone=$normalizedPhone&text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      await Share.share(
        'Transaction Receipt\nCustomer: $rawPhone\nReceipt Link: $pdfUrl',
      );
    }
  }
}