import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:maxpay/controllers/transaction_report_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';

class DisputeDialog extends StatefulWidget {
  final String rechargeId;

  const DisputeDialog({super.key, required this.rechargeId});

  @override
  State<DisputeDialog> createState() => _DisputeDialogState();
}

class _DisputeDialogState extends State<DisputeDialog> {
  String? selectedSubject;
  final TextEditingController descController = TextEditingController();

  final List<String> subjects = [
"Amount not credited",
"Balance mismatch ",
"Commission not credited",
"Please call me",
"Transaction failed but amount debited",
"Transaction success but amount not debited",
"Others"

  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Send Complaints",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 15),

            const Text("Subject"),

            const SizedBox(height: 6),

            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: selectedSubject,
              decoration: InputDecoration(
                hintText: "Select Subject",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              items: subjects.map((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSubject = value;
                });
              },
            ),

            const SizedBox(height: 12),

            const Text("Description"),

            const SizedBox(height: 6),

            TextFormField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    /// Call Complaint API Here

                    print("Transaction ID: ${widget.rechargeId}");
                    print("Subject: $selectedSubject");
                    print("Description: ${descController.text}");

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.clrPrimary,
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedSubject == null || selectedSubject!.isEmpty) {
                      CustomToast.error("Please select subject");
                      return;
                    }

                    if (descController.text.trim().isEmpty) {
                      CustomToast.error("Please enter description");
                      return;
                    }

                    final controller = Get.find<TransReportController>();

                    await controller.SubmitDispute(
                      subject: selectedSubject!,
                      rechargeid: widget.rechargeId,
                      description: descController.text.trim(),
                    );

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.clrPrimary,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
