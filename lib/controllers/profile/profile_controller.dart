import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/utils/snackbar.dart';
import 'package:maxpay/core/data/model/profile_model.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase getProfileUseCase;
  final ProfileUpdateUseCase profileUpdateUseCase;

  ProfileController({
    required this.getProfileUseCase,
    required this.profileUpdateUseCase,
  });

  final profileData = Rxn<ProfileModel>();
  final isLoading = false.obs;
  final isUpdateLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final result = await getProfileUseCase();
    result.fold(
      (failure) {
        // Handle failure if needed, or silently fail on home screen
      },
      (success) {
        profileData.value = success;
        final data = success.data;
        if (data != null) {
          nameController.text = data.name ?? '';
          emailController.text = data.email ?? '';
          whatsappController.text = data.whatsappNumber ?? '';
          addressController.text = data.billingAddress ?? '';
          pincodeController.text = data.pincode ?? '';
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> updateProfile() async {
    isUpdateLoading.value = true;
    final Map<String, dynamic> data = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'whatsapp_number': whatsappController.text.trim(),
      'billing_address': addressController.text.trim(),
      'pincode': pincodeController.text.trim(),
    };

    final result = await profileUpdateUseCase(data);
    result.fold(
      (failure) {
        CustomToast.error(failure.message);
      },
      (success) {
        CustomToast.success(success['message'] ?? 'Profile updated successfully');
        getProfile(); // refresh data
        Get.back(); // navigate back after success
      },
    );
    isUpdateLoading.value = false;
  }
}
