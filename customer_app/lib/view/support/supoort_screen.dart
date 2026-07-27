import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/injection_container.dart';
import 'package:maxpay/controllers/support/support_controller.dart';
import 'package:flutter_ionicons/flutter_ionicons.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  late final SupportController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SupportController(getSupportUseCase: sl()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(title: "Support"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.supportData.isEmpty) {
          return const Center(child: Text("No support contacts available."));
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: controller.supportData.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = controller.supportData[index];

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: item.iconUrl != null ? NetworkImage(item.iconUrl!) : null,
                      child: item.iconUrl == null
                          ? Icon(
                              Icons.headset_mic_rounded,
                              color: Colors.grey.shade600,
                            )
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title ?? "Customer Support",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.phoneNumber ?? item.whatsappNumber ?? item.email ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.callEnabled == 1 && item.phoneNumber != null)
                      SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.callSupport(item.phoneNumber!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0DB561),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Icons.call,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "call",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    if (item.whatsappEnabled == 1 && item.whatsappNumber != null) ...[
                      if (item.callEnabled == 1 && item.phoneNumber != null)
                        const SizedBox(width: 8),
                      SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.openWhatsapp(item.whatsappNumber!);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF25D366),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(
                            Ionicons.logo_whatsapp,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "chat",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}