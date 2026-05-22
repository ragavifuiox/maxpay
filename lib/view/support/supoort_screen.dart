import 'package:flutter/material.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> supportList = [
      {
        "name": "Admin",
        "phone": "+91 0005451152",
      },
      {
        "name": "Sub Admin",
        "phone": "+91 0005451153",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      // Your global appbar already created
      // Example:
      appBar: const CommonAppBar(title: "Support"),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: supportList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final item = supportList[index];

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
                    color: Colors.black.withOpacity(0.03),
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
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"] ?? "",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          item["phone"] ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 36,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Call functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0EA5C6),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}