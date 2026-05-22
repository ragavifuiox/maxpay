import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;

  ProfileController({
    required this.getProfileUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<MyProfile?> profileData =
      Rx<MyProfile?>(null);

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;

    final result =
        await getProfileUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          failure.message,
        );
      },
      (data) {
        profileData.value = data;

        isLoading.value = false;
      },
    );
  }
}