import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/domain/usecase/downlaod_usecase.dart';

class DownloadController extends GetxController {
  final DownloadUsecase downloadUseCase;

  DownloadController({
    required this.downloadUseCase,
  });

  final Dio dio = Dio();

  RxBool isDownloading = false.obs;

  Future<void> downloadReceipt(String rechargeId) async {
    try {
      print("========== DOWNLOAD START ==========");
      print("Recharge ID : $rechargeId");

      isDownloading.value = true;

      final result = await downloadUseCase(
        successid: rechargeId,
      );

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

          final savePath =
              "${directory.path}/Receipt_$rechargeId.pdf";

          print("Save Path : $savePath");

          /// Get response as bytes
          final response = await dio.get(
            receiptUrl,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          );

          print("Status Code : ${response.statusCode}");
          print(
            "Content-Type : ${response.headers.value('content-type')}",
          );
          print("Headers : ${response.headers.map}");

          final bytes = response.data as List<int>;

          print("First 20 Bytes : ${bytes.take(20).toList()}");
          print(
            "First Characters : ${String.fromCharCodes(bytes.take(20))}",
          );

          /// Save file
          final file = File(savePath);

          await file.writeAsBytes(bytes);

          print("File Exists : ${await file.exists()}");
          print("File Size : ${await file.length()} bytes");

          print("========== DOWNLOAD COMPLETED ==========");

          CustomToast.success("Receipt saved in Downloads");
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