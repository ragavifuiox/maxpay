import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  XFile? _addressProofFile;
  XFile? _gstFile;
  XFile? _panCardFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickGalleryFile(ValueChanged<XFile> onPicked) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null && mounted) {
        setState(() {
          onPicked(image);
        });
      }
    } on PlatformException catch (error) {
      debugPrint(error.message ?? 'Unable to pick image');
    } catch (_) {
      debugPrint('Unable to pick image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(title: "KYC"),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// MAIL ID
                      Text(
                        "Mail ID",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// INPUT FIELD
                      Container(
                        height: 52,

                        decoration: BoxDecoration(
                          color: theme.brightness == Brightness.light
                              ? AppColors.border
                              : theme.colorScheme.surfaceContainer,

                          borderRadius: BorderRadius.circular(10),

                          border: Border.all(
                            color: AppColors.darktextclr.withValues(alpha: 0.1),
                          ),
                        ),

                        child: TextFormField(
                          style: TextStyle(color: theme.colorScheme.onSurface),

                          decoration: InputDecoration(
                            hintText: "Enter your mail id",

                            hintStyle: TextStyle(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),

                            border: InputBorder.none,

                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// ADDRESS PROOF
                      Text(
                        "Address Proof",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _addressProofFile,
                        onTap: () => _pickGalleryFile(
                          (file) => _addressProofFile = file,
                        ),
                      ),

                      const SizedBox(height: 22),

                      /// GST NO
                      Text(
                        "GST No",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _gstFile,
                        onTap: () =>
                            _pickGalleryFile((file) => _gstFile = file),
                      ),

                      const SizedBox(height: 22),

                      /// PAN CARD
                      Text(
                        "Pan Card",

                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      UploadCard(
                        file: _panCardFile,
                        onTap: () =>
                            _pickGalleryFile((file) => _panCardFile = file),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              /// SUBMIT BUTTON
              CommonButton(title: "SUbmit", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadCard extends StatelessWidget {
  const UploadCard({super.key, required this.onTap, this.file});

  final VoidCallback onTap;
  final XFile? file;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),

          decoration: BoxDecoration(
            color: theme.brightness == Brightness.light
                ? AppColors.border
                : theme.colorScheme.surfaceContainer,

            borderRadius: BorderRadius.circular(12),

            border: Border.all(
              color: AppColors.darktextclr.withValues(alpha: 0.1),
            ),
          ),

          child: Column(
            children: [
              if (file?.path != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(file!.path),
                    height: 90,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ] else ...[
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 26,
                  color: theme.colorScheme.onSurface,
                ),
              ],

              const SizedBox(height: 12),

              Text(
                "Browse and choose the files you want to upload\nfrom your Device",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 16),

              Container(
                height: 34,
                width: 34,

                decoration: BoxDecoration(
                  color: const Color(0xff0C8A5B),

                  borderRadius: BorderRadius.circular(6),
                ),

                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),

              if (file != null) ...[
                const SizedBox(height: 12),
                Text(
                  file!.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
