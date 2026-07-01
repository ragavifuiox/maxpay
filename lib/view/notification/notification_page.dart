import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/notification_controller.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final NotificationController controller =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Notification"),
      body: Obx(
        () => controller.notifications.isEmpty
            ? const Center(
                child: Text("No Notifications"),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  final item = controller.notifications[index];

                  return GestureDetector(
                    onTap: () => controller.markAsRead(index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: item["isRead"]
                            ? Colors.white
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: item["isRead"]
                                ? Colors.grey
                                : Colors.blue,
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["title"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item["message"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item["time"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (!item["isRead"])
                            const Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 10,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}