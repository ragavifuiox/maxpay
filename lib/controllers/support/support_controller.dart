import 'package:get/get.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/usecase/get_support_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportController extends GetxController {
  final GetSupportUseCase getSupportUseCase;

  SupportController({required this.getSupportUseCase});

  final supportData = RxList<SupportData>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getSupport();
  }

  Future<void> getSupport() async {
    isLoading.value = true;
    final result = await getSupportUseCase();
    result.fold(
      (failure) {
        // Handle failure silently or show error
      },
      (success) {
        if (success.data != null) {
          supportData.value = success.data!;
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> callSupport(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> openWhatsapp(String whatsappNumber) async {
    final Uri url = Uri.parse("whatsapp://send?phone=$whatsappNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
