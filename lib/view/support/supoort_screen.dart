import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/support_controller.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final SupportController controller = Get.find<SupportController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CommonAppBar(title: "Support"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final supportList = controller.supportData.value?.data ?? [];

        if (supportList.isEmpty) {
          return const Center(
            child: Text("No Support Data Found"),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: supportList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            final item = supportList[index];

            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.dark
                    ? theme.cardColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.grey.withOpacity(.15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  /// Avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade500,
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// Name & Phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? "",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.phoneNumber ?? "",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Right Side Buttons
                  Column(
                    children: [
                     _SupportButton(
  image: "assets/images/wp-icon.svg",
  onTap: () => openWhatsApp(item.phoneNumber ?? ""),
),

const SizedBox(height: 10),

_SupportButton(
  image: "assets/images/call-icon.svg",
  onTap: () => makeCall(item.phoneNumber ?? ""),
),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

class _SupportButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const _SupportButton({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Container(
        width: 46,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xff11A7C7),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            image,
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
/// Make Phone Call
void makeCall(String phoneNumber) async {
  final Uri url = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } else {
    Get.snackbar(
      "Error",
      "Cannot open dialer",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

/// Open WhatsApp
Future<void> openWhatsApp(String phoneNumber) async {
  String number = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  if (number.length == 10) {
    number = "91$number";
  }

  const message =
      "👋 Hello! I need support regarding my account.";

  final Uri uri = Uri.parse(
    "https://wa.me/$number?text=${Uri.encodeComponent(message)}",
  );

  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      "Unable to open WhatsApp",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}