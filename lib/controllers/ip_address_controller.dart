import 'package:get/get.dart';
import 'package:maxpay/core/domain/usecase/ip_address_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class IpAddressController extends GetxController {
  final IpAddressUsecase ipAddressUseCase;

  IpAddressController({
    required this.ipAddressUseCase,
  });

  RxBool isLoading = false.obs;

  Future<void> saveIpAddress({
    required String ipaddress,
    required String city,
    required String state,
    required String network,
  }) async {
    try {
      isLoading.value = true;

      AppLogger.logError("=========== IP REQUEST ===========");

      AppLogger.logError({
        "ip_address": ipaddress,
        "city": city,
        "state": state,
        "network": network,
      });

      final result = await ipAddressUseCase(
         ipaddress,
         city,
         state,
       network,
      );

      result.fold(
        (failure) {
          AppLogger.logError(
            "IP SAVE FAILED => ${failure.message}",
          );
        },
        (response) {
          AppLogger.logError(
            "IP SAVE SUCCESS => ${response.message}",
          );
        },
      );
    } catch (e) {
      AppLogger.logError(
        "IP SAVE EXCEPTION => $e",
      );
    } finally {
      isLoading.value = false;
    }
  }
}