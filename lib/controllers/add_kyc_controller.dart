import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:maxpay/core/domain/usecase/kyc_usecase.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:image_picker/image_picker.dart';

class AddKycController extends GetxController {
  final AddKycUsecase addKycUsecase;

  AddKycController({required this.addKycUsecase});

  RxBool isLoading = false.obs;

  final emailController = TextEditingController();

  Rx<File?> idProof = Rx<File?>(null);
  Rx<File?> gstNo = Rx<File?>(null);
  Rx<File?> pan = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 'idProof') idProof.value = File(image.path);
      if (type == 'gstNo') gstNo.value = File(image.path);
      if (type == 'pan') pan.value = File(image.path);
    }
  }

  Future<void> submitKyc() async {
    if (emailController.text.isEmpty) {
      CustomToast.error("Please enter Mail ID");
      return;
    }
    if (idProof.value == null) {
      CustomToast.error("Please upload Address Proof");
      return;
    }
    if (gstNo.value == null) {
      CustomToast.error("Please upload GST No");
      return;
    }
    if (pan.value == null) {
      CustomToast.error("Please upload Pan Card");
      return;
    }

    isLoading(true);

    final result = await addKycUsecase(
      emailController.text.trim(), 
      idProof.value!, 
      gstNo.value!, 
      pan.value!
    );

    isLoading(false);

    result.fold((Failure failure) {
      CustomToast.error(failure.message);
    }, (response) {
      if (response.success == true) {
        CustomToast.success(response.message ?? "KYC Submitted successfully");
        Get.back();
      } else {
        CustomToast.error(response.message ?? "Failed to submit KYC");
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
