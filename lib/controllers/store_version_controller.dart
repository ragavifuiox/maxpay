import 'package:get/get.dart';
import 'package:maxpay/core/data/model/store_version_model.dart';
import 'package:maxpay/core/domain/usecase/store_version_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

import 'package:package_info_plus/package_info_plus.dart';

class StoreVersionController extends GetxController {
  final StoreVersionUsecase storeVersionUsecase;

  StoreVersionController({required this.storeVersionUsecase});

  RxBool isLoading = false.obs;
  Rx<StoreVersionModel?> storeVersionData = Rx<StoreVersionModel?>(null);

  @override
  void onInit() {
    super.onInit();
    _initStoreVersion();
  }

  Future<void> _initStoreVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      fetchStoreVersion(version: packageInfo.version);
    } catch (e) {
      AppLogger.logError("Failed to get package info: $e");
      // Fallback
      fetchStoreVersion(version: "1.2.50");
    }
  }

  Future<void> fetchStoreVersion({required String version}) async {
    try {
      isLoading.value = true;
      AppLogger.debugPrint(
        "🚀 [API CALL START] fetchStoreVersion payload (version): $version",
      );

      final result = await storeVersionUsecase(version: version);

      result.fold(
        (failure) {
          AppLogger.logError(
            "❌ [API CALL FAILED] fetchStoreVersion: ${failure.message}",
          );
        },
        (data) {
          AppLogger.debugPrint(
            "✅ [API CALL SUCCESS] fetchStoreVersion response data: data exists",
          );
          storeVersionData.value = data;
        },
      );
    } catch (e, stackTrace) {
      AppLogger.logError("🔥 [API CALL EXCEPTION] fetchStoreVersion error: $e");
      AppLogger.logError("🔥 StackTrace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }
}
