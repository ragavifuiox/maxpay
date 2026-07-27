import 'package:flutter/material.dart';
import 'package:maxpay/core/constants/colors.dart';

class EarningsCard extends StatelessWidget {
  const EarningsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration( 
  color: theme.brightness == Brightness.light
      ? AppColors.background
      : theme.colorScheme.surfaceContainer,

  borderRadius: BorderRadius.circular(12),

  border: Border.all(
    color: Colors.grey.withValues(alpha: 0.1),
    width: 1,
  ),
),

      child: Column(
        children: [
       
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time:",
                style: TextStyle(
                  fontSize: 12,
                 color:AppColors.darktextclr ,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                "2026-11-29 14:38:43",
                style: TextStyle(
                  fontSize: 12,
                 color: AppColors.darktextclr ,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// 🔹 Divider
          Divider(
            color:AppColors.darktextclr ,
          ),

          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Avatar
              Row(
                children: const [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red,
                    child: Text(
                      "J",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  SizedBox(width: 10),
                ],
              ),

              /// Name + Amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jio",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Total Amount : ₹100",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              /// Earnings
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "My Earnings",
                    style: TextStyle(
                      fontSize: 11,
                       color: AppColors.darktextclr ,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "₹ 5",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}