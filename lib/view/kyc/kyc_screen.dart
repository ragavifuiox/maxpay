import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controllers/add_kyc_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(AddKycController(addKycUsecase: sl()));
    controller.emailController.text =
        Get.find<ProfileController>().profileData.value?.data?.email ?? '';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "KYC"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mail ID",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light
                      ? AppColors.background
                      : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: TextFormField(
                  controller: controller.emailController,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: "Enter Mail ID",
                    hintStyle: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "Address Proof",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => UploadCard(
                  onTap: () => controller.pickImage('idProof'),
                  selectedFile: controller.idProof.value,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "GST No",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => UploadCard(
                  onTap: () => controller.pickImage('gstNo'),
                  selectedFile: controller.gstNo.value,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                "Pan Card",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => UploadCard(
                  onTap: () => controller.pickImage('pan'),
                  selectedFile: controller.pan.value,
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: Obx(
                  () => CommonButton(
                    title: controller.isLoading.value ? "Loading..." : "Submit",
                    onTap: () => controller.submitKyc(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadCard extends StatelessWidget {
  final VoidCallback onTap;
  final File? selectedFile;

  const UploadCard({super.key, required this.onTap, this.selectedFile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? AppColors.background
              : theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: selectedFile != null
            ? Column(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    selectedFile!.path.split('/').last,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              )
            : Column(
                spacing: 4,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 42,
                    color: theme.colorScheme.onSurface,
                  ),

                  Text(
                    "Browse and choose the files you want\nto upload from your Device",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.5,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: const Color(0xff0C8A5B),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ],
              ),
      ),
    );
  }
}
