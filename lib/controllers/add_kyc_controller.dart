// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:maxpay/controllers/profile_controller.dart';
// import 'package:maxpay/core/data/model/get_kyc_model.dart';
// import 'package:maxpay/core/domain/usecase/get_kyc_usecase.dart';
// import 'package:maxpay/core/domain/usecase/kyc_usecase.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/constants/snackbar.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:maxpay/core/utils/logg_helper.dart';

// class AddKycController extends GetxController {
//   final AddKycUsecase addKycUsecase;
//   final GetKycUsecase getkycUsecase;

//   AddKycController({

//     required this.addKycUsecase,
//     required this.getkycUsecase
//     });

//   RxBool isLoading = false.obs;

//   final emailController = TextEditingController();
//  final Rx<GetKyc?> news = Rx<GetKyc?>(null);
//   Rx<File?> idProof = Rx<File?>(null);
//   Rx<File?> gstNo = Rx<File?>(null);
//   Rx<File?> pan = Rx<File?>(null);

//   final ImagePicker _picker = ImagePicker();
// RxBool isKycSubmitted = false.obs;
// @override
// void onInit() {
//   super.onInit();

//   emailController.text =
//       Get.find<ProfileController>().profileData.value?.data?.email ?? '';

//   fetchkyc();
// }

//   Future<void> pickImage(String type) async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       if (type == 'idProof') idProof.value = File(image.path);
//       if (type == 'gstNo') gstNo.value = File(image.path);
//       if (type == 'pan') pan.value = File(image.path);
//     }
//   }

//   Future<void> submitKyc() async {
//     if (emailController.text.isEmpty) {
//       CustomToast.error("Please enter Mail ID");
//       return;
//     }
//     if (idProof.value == null) {
//       CustomToast.error("Please upload Address Proof");
//       return;
//     }
//     if (gstNo.value == null) {
//       CustomToast.error("Please upload GST No");
//       return;
//     }
//     if (pan.value == null) {
//       CustomToast.error("Please upload Pan Card");
//       return;
//     }

//     isLoading(true);

//     final result = await addKycUsecase(
//       emailController.text.trim(),
//       idProof.value!,
//       gstNo.value!,
//       pan.value!
//     );

//     isLoading(false);

//     result.fold((Failure failure) {
//       CustomToast.error(failure.message);
//     }, (response) {
//       if (response.success == true) {
//         CustomToast.success(response.message ?? "KYC Submitted successfully");
//         Get.back();
//       } else {
//         CustomToast.error(response.message ?? "Failed to submit KYC");
//       }
//     });
//   }
// Future<void> fetchkyc() async {
//   try {
//     isLoading.value = true;

//     final result = await getkycUsecase();

//     result.fold(
//       (failure) {
//         Get.snackbar('Error', failure.message);
//       },
//       (data) {
//         news.value = data;

//         if (data.data != null) {
//           emailController.text = data.data?.email ?? '';

//           isKycSubmitted.value = true;
//         }
//       },
//     );
//   } finally {
//     isLoading.value = false;
//   }
// }
//   @override
//   void onClose() {
//     emailController.dispose();
//     super.onClose();
//   }
// }

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/data/model/get_kyc_model.dart';
import 'package:maxpay/core/domain/usecase/get_kyc_usecase.dart';
import 'package:maxpay/core/domain/usecase/kyc_usecase.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AddKycController extends GetxController {
  final AddKycUsecase addKycUsecase;
  final GetKycUsecase getkycUsecase;

  AddKycController({required this.addKycUsecase, required this.getkycUsecase});

  RxBool isLoading = false.obs;
  RxBool isKycSubmitted = false.obs;

  final emailController = TextEditingController();

  final Rx<GetKyc?> news = Rx<GetKyc?>(null);

  Rx<File?> idProof = Rx<File?>(null);
  Rx<File?> gstNo = Rx<File?>(null);
  Rx<File?> pan = Rx<File?>(null);

  RxString addressFileName = ''.obs;
  RxString gstFileName = ''.obs;
  RxString panFileName = ''.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    emailController.text =
        Get.find<ProfileController>().profileData.value?.data?.email ?? '';

    fetchkyc();
  }

  Future<void> pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      AppLogger.debugPrint("Selected Image: ${image.path}");

      if (type == 'idProof') {
        idProof.value = File(image.path);
        addressFileName.value = image.name;
      }

      if (type == 'gstNo') {
        gstNo.value = File(image.path);
        gstFileName.value = image.name;
      }

      if (type == 'pan') {
        pan.value = File(image.path);
        panFileName.value = image.name;
      }
    }
  }

  Future<void> submitKyc() async {
    AppLogger.debugPrint("===== KYC SUBMIT START =====");

    AppLogger.debugPrint({
      "email": emailController.text.trim(),
      "addressProof": idProof.value?.path,
      "gstFile": gstNo.value?.path,
      "panFile": pan.value?.path,
    });

    isLoading.value = true;

    final result = await addKycUsecase(
      emailController.text.trim(),
      idProof.value!,
      gstNo.value!,
      pan.value!,
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        AppLogger.logError({"status": "FAILED", "message": failure.message});

        CustomToast.error(failure.message);
      },
      (response) {
        AppLogger.debugPrint({
          "success": response.success,
          "message": response.message,
        });

        if (response.success == true) {
          CustomToast.success(response.message ?? "KYC Submitted Successfully");

          fetchkyc();
        } else {
          CustomToast.error(response.message ?? "Failed to submit KYC");
        }
      },
    );
  }

  Future<void> fetchkyc() async {
    try {
      isLoading.value = true;

      final result = await getkycUsecase();

      result.fold(
        (failure) {
             CustomToast.error(failure.message);
         
        },
        (data) {
          news.value = data;

          if (data.success == true && data.data != null) {
            emailController.text = data.data?.email ?? '';

          addressFileName.value = data.data?.address ?? '';

gstFileName.value = data.data?.gstNo ?? '';

panFileName.value = data.data?.pan ?? '';

            isKycSubmitted.value = true;
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
