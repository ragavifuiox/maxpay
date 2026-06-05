import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/commom_button.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "KYC",
      ),

      /// ✅ Submit button scroll aagum
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              /// MAIL ID
              Text(
                "Mail ID",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              /// INPUT FIELD
              Container(
                height: 52,

                decoration: BoxDecoration(
                  color:
                      theme.brightness ==
                              Brightness.light
                          ? AppColors.background
                          : theme.colorScheme
                              .surfaceContainer,

                  borderRadius:
                      BorderRadius.circular(10),

                  border: Border.all(
                    color:
                        theme.colorScheme.outline,
                  ),
                ),

                child: TextFormField(
                  style: TextStyle(
                    color:
                        theme.colorScheme.onSurface,
                  ),

                  decoration: InputDecoration(
                    hintText: "Enter Mail ID",

                    hintStyle: TextStyle(
                      color: theme.colorScheme
                          .onSurfaceVariant,
                      fontSize: 14,
                    ),

                    border: InputBorder.none,

                    contentPadding:
                        const EdgeInsets.symmetric(
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
                  color:
                      theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              const UploadCard(),

              const SizedBox(height: 22),

              /// GST NO
              Text(
                "GST No",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              const UploadCard(),

              const SizedBox(height: 22),

              /// PAN CARD
              Text(
                "Pan Card",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color:
                      theme.colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              const UploadCard(),

              const SizedBox(height: 35),

              /// ✅ SUBMIT BUTTON INSIDE SCROLL
              Center(
                child: CommonButton(
                  title: "Submit",
                  onTap: () {},
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
  const UploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),

      decoration: BoxDecoration(
        color:
            theme.brightness ==
                    Brightness.light
                ? AppColors.background
                : theme.colorScheme
                    .surfaceContainer,

        borderRadius:
            BorderRadius.circular(12),

        border: Border.all(
          color:
              theme.colorScheme.outline,
        ),
      ),

      child: Column(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            size: 26,
            color:
                theme.colorScheme.onSurface,
          ),

          const SizedBox(height: 12),

          Text(
            "Browse and choose the files you want to upload\nfrom your Device",

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: theme.colorScheme
                  .onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          Container(
            height: 34,
            width: 34,

            decoration: BoxDecoration(
              color: const Color(
                0xff0C8A5B,
              ),

              borderRadius:
                  BorderRadius.circular(
                6,
              ),
            ),

            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}