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
          separatorBuilder: (_, _) => const SizedBox(height: 18),
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
      backgroundColor: const Color(0xFF25D366), // WhatsApp Green
      icon: const FaIcon(
        FontAwesomeIcons.whatsapp,
        color: Colors.white,
        size: 14,
      ),
      onTap: () => openWhatsApp(item.phoneNumber ?? ""),
    ),

    const SizedBox(height: 8),

    _SupportButton(
      backgroundColor: const Color(0xFF3F51B5), // Blue
      icon: const Icon(
        Icons.call,
        color: Colors.white,
        size: 14,
      ),
      onTap: () => makeCall(item.phoneNumber ?? ""),
    ),
  ],
)
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
  final Widget icon;
  final VoidCallback onTap;
  final Color backgroundColor;

  const _SupportButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 29,
        height: 25,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: icon),
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