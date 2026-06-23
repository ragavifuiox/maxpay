import 'dart:io';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';

import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/webview.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
 final ProfileUpdateUsecase profileUpdateUseCase;
  ProfileController({required this.getProfileUseCase,required this.profileUpdateUseCase,
  });

  RxBool isLoading = false.obs;

  Rx<MyProfile?> profileData = Rx<MyProfile?>(null);

Rx<File?> selectedImage = Rx<File?>(null);

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
      AppLogger.logError("PROFILE ERROR: ${failure.message}");

      isLoading.value = false;
      Get.snackbar('Error', failure.message);
    },
    (data) {
      AppLogger.debugPrint("===== PROFILE RESPONSE =====");

      if (data.toJson != null) {
        AppLogger.debugPrint(data.toJson());
      }

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


 Future<void> updateProfile({
  required String name,
  required String email,
  required String mobile,
  required String pincode,
  required String profileImage,
}) async {
  isLoading.value = true;

  final result = await profileUpdateUseCase(
    pincode,
    email,
    mobile,
    name,
    profileImage,
  );

  result.fold(
    (failure) {
      AppLogger.logError("UPDATE ERROR: ${failure.message}");


     CustomToast.error(failure.message);
    },
    (response) async {
      AppLogger.debugPrint("===== UPDATE RESPONSE =====");

      AppLogger.debugPrint({
        "retailer_name": response.data?.retailerName,
        "message": response.message,
      });

      await fetchProfile();

     
      CustomToast.success(
        response.message ?? "Profile Updated Successfully",
      );

    },
  );

  isLoading.value = false;
}


Future<void> pickImage() async {
  final picker = ImagePicker();

  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (image != null) {
    selectedImage.value = File(image.path);
  }
}
}
