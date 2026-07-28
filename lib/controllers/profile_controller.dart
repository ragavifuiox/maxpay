// import 'dart:async';
// import 'dart:io';

// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:maxpay/core/constants/snackbar.dart';
// import 'package:maxpay/core/data/model/get_profile_model.dart';
// import 'package:maxpay/core/data/model/update_profile_otp_model.dart';
// import 'package:maxpay/core/data/repsoitory/update_profile_repo_impl.dart';

// import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
// import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';
// import 'package:maxpay/core/domain/usecase/update_profile_otp_usecase.dart';
// import 'package:maxpay/core/utils/logg_helper.dart';
// import 'package:maxpay/global_widget/webview.dart';
// import 'package:maxpay/view/login/otp_verification_screen.dart';
// import 'package:maxpay/view/profile/profile_update_otp.dart';

// class ProfileController extends GetxController {
//   final GetProfileUseCase getProfileUseCase;
//   final ProfileUpdateUsecase profileUpdateUseCase;
//   final UpdateProfileOtpUsecase updateprofileotpusecase;
//   ProfileController({
//     required this.getProfileUseCase,
//     required this.profileUpdateUseCase,
//     required this.updateprofileotpusecase,
//   });
// RxString updatedMobile = "".obs;
//   RxBool isLoading = false.obs;

//   Rx<MyProfile?> profileData = Rx<MyProfile?>(null);

//   Rx<File?> selectedImage = Rx<File?>(null);
//  Rxn<UpdateprofileOtp> updateOtpResponse = Rxn<UpdateprofileOtp>();
//   // Tracks the phone number as last loaded from the server, so we can
//   // pass it to the OTP screen after an update.
//   String _lastKnownMobile = "";
// Timer? _timer;
//   @override
//   void onInit() {
//     fetchProfile();
//     super.onInit();
//   }

// RxInt remainingSeconds = 60.obs;
// RxBool canResendOtp = false.obs;
//  void startOtpTimer() {
//   _timer?.cancel();

//   remainingSeconds.value = 60;
//   canResendOtp.value = false;

//   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//     if (remainingSeconds.value > 0) {
//       remainingSeconds.value--;
//     } else {
//       canResendOtp.value = true;
//       timer.cancel();
//     }
//   });
// }

// void stopTimer() {
//   _timer?.cancel();
// }
//   Future<void> fetchProfile() async {
//     isLoading.value = true;

//     final result = await getProfileUseCase();

//     result.fold(
//       (failure) {
//         AppLogger.logError("PROFILE ERROR: ${failure.message}");

//         isLoading.value = false;
//         Get.snackbar('Error', failure.message);
//       },
//       (data) {
//         AppLogger.debugPrint("===== PROFILE RESPONSE =====");

//         AppLogger.debugPrint(data.toJson());

//         profileData.value = data;
//         profileData.refresh();

//         // TODO: confirm the actual field name on MyProfile.data for the
//         // phone number (it was `phoneNumber` in the earlier profile screen).
//         _lastKnownMobile = data.data?.phoneNumber ?? _lastKnownMobile;

//         isLoading.value = false;
//       },
//     );
//   }

//   Future<void> fetchPrivacyPolicyLink() async {
//     isLoading.value = true;

//     final result = await getProfileUseCase.repository.getPrivacyPolicy();

//     result.fold(
//       (failure) {
//         isLoading.value = false;

//         Get.snackbar('Error', failure.message);
//       },
//       (data) {
//         final uri = data.data?.privacyPolicy;
//         if (uri != null && uri.isNotEmpty) {
//           Get.to(
//             () => WebViewPageFlutter(
//               url: "http://139.59.91.7/test_paylinkonline.in/public/privacy",
//               title: "Privacy Policy",
//             ),
//           );
//         }
//         isLoading.value = false;
//       },
//     );
//   }







// Future<bool> verifyOtp(String otp) async {
//   try {
//     isLoading.value = true;

//     final result = await updateprofileotpusecase(
//       otp,
//       updatedMobile.value,
//     );

//     return result.fold(
//       (failure) {
//         AppLogger.logError(failure.message);
//         return false;
//       },
//       (response) {
//         updateOtpResponse.value = response;
//         return response.success == true;
//       },
//     );
//   } finally {
//     isLoading.value = false;
//   }
// }



// Future<void> updateProfile({
//   required String name,
//   required String email,
//   required String mobile,
//   required String pincode,
//   File? profileImage,
//   required String address,
//   required String whatsappnumber,
// }) async {
//   isLoading.value = true;

//   print("========== UPDATE PROFILE REQUEST ==========");
//   print({
//     "name": name,
//     "email": email,
//     "mobile": mobile,
//     "pincode": pincode,
//     "address": address,
//     "whatsappnumber": whatsappnumber,
//     "profileImage": profileImage?.path,
//   });

//   final result = await profileUpdateUseCase(
//     pincode: pincode,
//     email: email,
//     mobilenumber: mobile,
//     name: name,
//     profileimage: profileImage,
//     whatsappnumber: whatsappnumber,
//     address: address,
//   );

//   result.fold(
//     (failure) {
//       print("========== UPDATE PROFILE ERROR ==========");
//       print(failure.message);

//       AppLogger.logError(
//         "UPDATE ERROR: ${failure.message}",
//       );

//       CustomToast.error(failure.message);
//     },
//     (response) async {
//       print("========== UPDATE PROFILE RESPONSE ==========");

//       print("Message : ${response.message}");
//       print("Data : ${response.data}");
//       print("Retailer Name : ${response.data?.retailerName}");
//       print("OTP Required : ${response.data?.otpRequired}");

//       // If model contains toJson()
//       try {
//         print("FULL RESPONSE JSON : ${response.toJson()}");
//       } catch (e) {
//         print("Response JSON not available");
//         print(response);
//       }

//       final otpRequired = response.data?.otpRequired ?? false;

//       print("OTP CHECK VALUE : $otpRequired");

//      if (otpRequired) {
//   updatedMobile.value = mobile;

//   CustomToast.success("OTP sent to $mobile");

//   Get.to(() => const ProfileUpdateOtp());
// } else {
//         print("Profile update success without OTP");

//         await fetchProfile();

//         selectedImage.value = null;

//         CustomToast.success(
//           response.message ?? "Profile Updated Successfully",
//         );
//       }
//     },
//   );

//   isLoading.value = false;

//   print("========== UPDATE PROFILE END ==========");
// }

//   Future<void> pickImage() async {
//     final picker = ImagePicker();

//     final XFile? image = await picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 70,
//     );

//     if (image != null) {
//       selectedImage.value = File(image.path);
//     }
//   }
// }


import 'dart:async';
import 'dart:io';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/data/model/update_profile_otp_model.dart';
import 'package:maxpay/core/data/repsoitory/update_profile_repo_impl.dart';

import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_profile_otp_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
import 'package:maxpay/global_widget/webview.dart';
import 'package:maxpay/view/login/otp_verification_screen.dart';
import 'package:maxpay/view/profile/profile_update_otp.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final ProfileUpdateUsecase profileUpdateUseCase;
  final UpdateProfileOtpUsecase updateprofileotpusecase;
  ProfileController({
    required this.getProfileUseCase,
    required this.profileUpdateUseCase,
    required this.updateprofileotpusecase,
  });

  RxString updatedMobile = "".obs;
  RxBool isLoading = false.obs;

  Rx<MyProfile?> profileData = Rx<MyProfile?>(null);

  Rx<File?> selectedImage = Rx<File?>(null);
  Rxn<UpdateprofileOtp> updateOtpResponse = Rxn<UpdateprofileOtp>();

  // Tracks the phone number as last loaded from the server, so we can
  // pass it to the OTP screen after an update.
  String _lastKnownMobile = "";
  Timer? _timer;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  RxInt remainingSeconds = 60.obs;
  RxBool canResendOtp = false.obs;

  void startOtpTimer() {
    _timer?.cancel();

    remainingSeconds.value = 60;
    canResendOtp.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
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

        AppLogger.debugPrint(data.toJson());

        profileData.value = data;
        profileData.refresh();

        _lastKnownMobile = data.data?.phoneNumber ?? _lastKnownMobile;

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

  Future<bool> verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final result = await updateprofileotpusecase(
        otp,
        updatedMobile.value,
      );

      return result.fold(
        (failure) {
          AppLogger.logError(failure.message);
          return false;
        },
        (response) {
          updateOtpResponse.value = response;
          return response.success == true;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String mobile,
    required String pincode,
    File? profileImage,
    required String address,
    required String whatsappnumber,
  }) async {
    isLoading.value = true;

    print("========== UPDATE PROFILE REQUEST ==========");
    print({
      "name": name,
      "email": email,
      "mobile": mobile,
      "pincode": pincode,
      "address": address,
      "whatsappnumber": whatsappnumber,
      "profileImage": profileImage?.path,
    });

    final result = await profileUpdateUseCase(
      pincode: pincode,
      email: email,
      mobilenumber: mobile,
      name: name,
      profileimage: profileImage,
      whatsappnumber: whatsappnumber,
      address: address,
    );

    result.fold(
      (failure) {
        print("========== UPDATE PROFILE ERROR ==========");
        print(failure.message);

        AppLogger.logError(
          "UPDATE ERROR: ${failure.message}",
        );

        CustomToast.error(failure.message);
      },
      (response) async {
        print("========== UPDATE PROFILE RESPONSE ==========");

        print("Message : ${response.message}");
        print("Data : ${response.data}");
        print("Retailer Name : ${response.data?.retailerName}");
        print("OTP Required : ${response.data?.otpRequired}");

        // If model contains toJson()
        try {
          print("FULL RESPONSE JSON : ${response.toJson()}");
        } catch (e) {
          print("Response JSON not available");
          print(response);
        }

        final otpRequired = response.data?.otpRequired ?? false;

        print("OTP CHECK VALUE : $otpRequired");

        if (otpRequired) {
          updatedMobile.value = mobile;

          CustomToast.success("OTP sent to $mobile");

          Get.to(() => const ProfileUpdateOtp());
        } else {
          print("Profile update success without OTP");

          await fetchProfile();

          selectedImage.value = null;

          CustomToast.success(
            response.message ?? "Profile Updated Successfully",
          );
        }
      },
    );

    isLoading.value = false;

    print("========== UPDATE PROFILE END ==========");
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