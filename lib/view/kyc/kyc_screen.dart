import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/profile_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controllers/add_kyc_controller.dart';
import 'package:maxpay/core/di/service_locator.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.put(
      AddKycController(
        addKycUsecase: sl(),
        getkycUsecase: sl(),
      ),
    );

    final profileController = Get.find<ProfileController>();

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
                width: double.infinity,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.light
                      ? AppColors.background
                      : theme.colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.colorScheme.outline),
                ),
                child: Obx(() {
                  final email =
                      profileController.profileData.value?.data?.email ?? "";

                  // Keep the controller's text in sync since submitKyc()
                  // still reads from it, even though there's no visible
                  // editable field anymore.
                  controller.emailController.text = email;

                  return Text(
                    email.isNotEmpty ? email : "-",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 22),
              Text(
                "Bank Details",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => UploadCard(
                  onTap: controller.isKycSubmitted.value
                      ? () {}
                      : () => controller.pickImage('idProof'),
                  selectedFile: controller.idProof.value,
                  fileName: controller.addressFileName.value,
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
                  onTap: controller.isKycSubmitted.value
                      ? () {}
                      : () => controller.pickImage('gstNo'),
                  selectedFile: controller.gstNo.value,
                  fileName: controller.gstFileName.value,
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
                  onTap: controller.isKycSubmitted.value
                      ? () {}
                      : () => controller.pickImage('pan'),
                  selectedFile: controller.pan.value,
                  fileName: controller.panFileName.value,
                ),
              ),
              const SizedBox(height: 35),
              Obx(() {
                if (controller.isKycSubmitted.value) {
                  return const SizedBox();
                }

                return Center(
                  child: CommonButton(
                    title: controller.isLoading.value ? "Loading..." : "Submit",
                    onTap: controller.submitKyc,
                  ),
                );
              }),
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
  final String fileName;

  const UploadCard({
    super.key,
    required this.onTap,
    this.selectedFile,
    this.fileName = '',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = fileName.addToBase();

    print("Image URL => $imageUrl");

    bool hasFile = selectedFile != null || fileName.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        clipBehavior: Clip.antiAlias,
        child: hasFile
            ? (selectedFile != null
                ? Image.file(
                    selectedFile!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ))
            : InkWell(
                onTap: onTap,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload_outlined, size: 42),
                      SizedBox(height: 10),
                      Text("Browse and choose files"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}