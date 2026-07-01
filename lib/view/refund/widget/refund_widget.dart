import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/extension.dart';
import 'package:maxpay/core/data/model/refund_model.dart';

class EarningsCard1 extends StatelessWidget {
  final RefundData data;

  const EarningsCard1({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? AppColors.background
            : const Color(0xFF2F3349),

        borderRadius: BorderRadius.circular(12),

        border: theme.brightness == Brightness.dark
            ? Border.all(
                color: const Color(0xFF3C3F52),
              )
            : null,
      ),

      child: Column(
        children: [
          /// 🔹 TOP ROW
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Date & Time:",

                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
                      : AppColors.darktextclr,
                  fontWeight: FontWeight.w500,
                ),
              ),

              
              Text(
  (data.dateTime != null && data.dateTime!.isNotEmpty)
      ? formatTransactionDate(data.dateTime!)
      : "-",
  style: TextStyle(
    fontSize: 12,
    color: isDark
        ? const Color(0xFFFFFFFF).withValues(alpha: 0.7)
        : AppColors.darktextclr,
    fontWeight: FontWeight.w500,
  ),
),
            ],
          ),

          const SizedBox(height: 8),

          /// 🔹 Divider
          Divider(
  color: Theme.of(context).brightness == Brightness.light
      ? Colors.black12
      : Colors.white24,
),


          const SizedBox(height: 8),

          /// 🔹 Bottom Row
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.center,

            children: [
              /// Avatar
              Container(
  width: 40.w,
  height: 40.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(6.r),
  ),
  child: Image.network(
    data.operatorLogo??'',
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.image_not_supported,
      );
    },
  ),
),
 const SizedBox(width: 18,),
              /// Name + Amount
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      data.operatorName ?? "",

                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                    
  "Transaction No: ${data.transactionNo ?? ''}",


                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color:
                            theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),

              /// Earnings
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,

                children: [
                  Text(
                    
  "₹ ${data.amount ?? '0'}",


                    style: TextStyle(
                      color:
                          theme.colorScheme.onSurface,
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