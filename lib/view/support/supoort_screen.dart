import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/support_controller.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final SupportController controller =
      Get.find<SupportController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: const CommonAppBar(
        title: "Support",
      ),

      body: Obx(() {

        /// Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// API DATA
        final supportList =
            controller.supportData.value?.data ?? [];

        /// Empty
        if (supportList.isEmpty) {
          return Center(
            child: Text(
              "No Support Data Found",

              style: TextStyle(
                color:
                    theme.colorScheme.onSurface,
              ),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),

          itemCount: supportList.length,

          separatorBuilder: (_, _) =>
              const SizedBox(height: 16),

          itemBuilder: (context, index) {

            final item = supportList[index];

            return Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),

              decoration: BoxDecoration(
                color:
                    theme.brightness ==
                            Brightness.dark
                        ? theme.colorScheme
                            .surfaceContainer
                        : Colors.white,

                borderRadius:
                    BorderRadius.circular(14),

                border: Border.all(
                  color:
                      theme.colorScheme.outline,
                ),

                boxShadow: [
                  BoxShadow(
                    color: theme.brightness ==
                            Brightness.dark
                        ? Colors.transparent
                        : Colors.black.withValues(alpha: 
                            0.03,
                          ),

                    blurRadius: 8,

                    offset:
                        const Offset(0, 2),
                  ),
                ],
              ),

              child: Row(
                children: [

                  /// Profile Icon
                  CircleAvatar(
                    radius: 24,

                    backgroundColor:
                        theme.brightness ==
                                Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,

                    child: Icon(
                      Icons.person,

                      color:
                          theme.brightness ==
                                  Brightness.dark
                              ? Colors.white70
                              : Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// Name + Phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Text(
                          item.name ?? "",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w600,

                            color: theme
                                .colorScheme
                                .onSurface,
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        Text(
                          item.phoneNumber ?? "",

                          style: TextStyle(
                            fontSize: 14,

                            color: theme
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),

               
                  SizedBox(
                    height: 36,
                      child:
                        ElevatedButton.icon(
                           onPressed: () {
                            makeCall(item.phoneNumber ?? "");
                          },
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(
                          0xff0EA5C6,
                        ),

                        elevation: 0,

                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 14,
                        ),

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            8,
                          ),
                        ),
                      ),

                      icon: const Icon(
                        Icons.call,
                        size: 16,
                        color: Colors.white,
                      ),

                      label: const Text(
                        "Call",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
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


void makeCall(String phoneNumber) async {
  final Uri url = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    Get.snackbar(
      "Error",
      "Cannot open dialer",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}