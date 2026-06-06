import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';

import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/global_widget/webview.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;

  ProfileController({required this.getProfileUseCase});

  RxBool isLoading = false.obs;

  Rx<MyProfile?> profileData = Rx<MyProfile?>(null);

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;

    final result = await getProfileUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar('Error', failure.message);
      },
      (data) {
        profileData.value = data;

        isLoading.value = false;
      },
    );
  }

  Future<void> fetchPrivacyPolicyLink() async {
    isLoading.value = true;

    final result = await getProfileUseCase.repository.getPrivacyPolicy();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar('Error', failure.message);
      },
      (data) {
        final uri = data.data?.privacyPolicy;
        if (uri != null && uri.isNotEmpty) {
          Get.to(
            () => WebViewPageFlutter(
              url: "http://139.59.91.7/test_paylinkonline.in/public/privacy",
              title: "Privacy Policy",
            ),
          );
        }
        isLoading.value = false;
      },
    );
  }
}
