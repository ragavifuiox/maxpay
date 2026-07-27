import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class DthRefreshScreen extends StatelessWidget {
  const DthRefreshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fieldColor = isDark ? AppColors.darkFilterBorder : AppColors.background;
    return Scaffold(
       backgroundColor: theme.scaffoldBackgroundColor,
       appBar: CommonAppBar(title: "Dth Refresh"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Customer ID
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Customer ID",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.cancel_outlined,
                            color: Colors.grey.shade600, size: 18),
                        const SizedBox(width: 8),
                        const Icon(Icons.contact_page_outlined,
                            color: Colors.deepOrange, size: 20),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Operator
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Airtel Tv",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/8/89/Airtel_logo.svg",
                      width: 45,
                      errorBuilder: (_, _, _) => const Icon(Icons.tv),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Title
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Customer Info",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 2,
                      color: Colors.deepOrange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Customer Card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text("Customer Name",style: TextStyle(color: AppColors.clrTextblack),),
                            SizedBox(height: 12),
                            Text("Current Balance",style: TextStyle(color: AppColors.clrTextblack)),
                            SizedBox(height: 12),
                            Text("Status",style: TextStyle(color: AppColors.clrTextblack)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xfffde7ea),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(":   Alagan",style: TextStyle(color: AppColors.clrTextblack)),
                            SizedBox(height: 12),
                            Text(":   1.98",style: TextStyle(color: AppColors.clrTextblack)),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Text(":   "),
                                Text(
                                  "Updated",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: 160,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff1EA8C5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
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