import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/constants/snackbar.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/controllers/bank_controller.dart';
import 'package:maxpay/core/data/model/bank_details_model.dart' as model;

const Color kCardBorder = Color(0xFF2F80ED); // solid card border line
const Color kCopyIconColor = Color(0xFF17B7C7); // teal copy icon
const Color kBracketColor = Color(0xFFE53935); // red QR corner brackets
const Color kHeaderBlue = Color(0xFF2F80ED);

class BankDetailsPage extends StatelessWidget {
  BankDetailsPage({super.key});

  final BankDetailController controller = Get.put(
    BankDetailController(bankdetailusecase: sl()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Bank Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final bankData = controller.bankData.value;
        if (bankData == null ||
            bankData.data == null ||
            bankData.data!.isEmpty) {
          return const Center(child: Text("No bank details available."));
        }

        final accounts = bankData.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: BankAccountCard(account: accounts[index]),
            );
          },
        );
      }),
    );
  }
}

class BankAccountCard extends StatelessWidget {
  final model.Data account;

  const BankAccountCard({super.key, required this.account});

  void _copyToClipboard(BuildContext context, String value, String label) {
    // Clipboard.setData(ClipboardData(text: value));
    CustomToast.success('Copied');
  }

  // void _openQrDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     builder: (_) => QrPreviewDialog(account: account),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.clrPrimary, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Bank logo
          BankLogoBadge(logoUrl: account.bankLogo, bankName: account.bankName),
          const SizedBox(width: 14),

          // Account text details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Acc. Name : ",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        account.accountName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Acc. Detail",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        _CopyIconButton(
                          onTap: () {
                            final String allDetails =
                                '''Bank Name: ${account.bankName ?? ''}
Account Type: ${account.accountType ?? ''}
Account Name: ${account.accountName ?? ''}
Account Number: ${account.accountNumber ?? ''}
IFSC Code: ${account.ifscCode ?? ''}
Branch: ${account.branch ?? ''}
UPI ID: ${account.upiId ?? ''}''';
                            _copyToClipboard(
                              context,
                              allDetails,
                              "Bank Details",
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("UPI ID", style: TextStyle(fontSize: 13)),
                        const SizedBox(width: 4),
                        _CopyIconButton(
                          onTap: () {
                            _copyToClipboard(
                              context,
                              account.upiId ?? "",
                              "UPI ID",
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // QR thumbnail — tap opens the big QR dialog
          GestureDetector(
            child: BracketedQrBox(
              data: account.upiId ?? '',
              boxSize: 56,
              qrSize: 40,
              bracketLength: 12,
              bracketThickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _CopyIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CopyIconButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          width: 14,
          height: 14,
          child: SvgPicture.asset(AssetImages.copy),
        ),
      ),
    );
  }
}

class BankLogoBadge extends StatelessWidget {
  final String? logoUrl;
  final String? bankName;

  const BankLogoBadge({super.key, this.logoUrl, this.bankName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            padding: const EdgeInsets.all(6),
            child: (logoUrl != null && logoUrl!.isNotEmpty)
                ? Image.network(
                    logoUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => _fallbackMark(),
                  )
                : _fallbackMark(),
          ),
        ],
      ),
    );
  }

  Widget _fallbackMark() {
    return const Icon(Icons.account_balance, color: kBracketColor, size: 20);
  }
}

// ---------------------------------------------------------------------------
// QR BOX WITH RED L-SHAPED CORNER BRACKETS (used in card + dialog)
// ---------------------------------------------------------------------------
class BracketedQrBox extends StatelessWidget {
  final String data;
  final double boxSize;
  final double qrSize;
  final double bracketLength;
  final double bracketThickness;

  const BracketedQrBox({
    super.key,
    required this.data,
    required this.boxSize,
    required this.qrSize,
    this.bracketLength = 16,
    this.bracketThickness = 2.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: QrImageView(
              data: data,
              version: QrVersions.auto,
              size: qrSize,
              gapless: true,
            ),
          ),
          // four L-shaped brackets
          Positioned(top: 4, left: 4, child: _corner(topLeft: true)),
          Positioned(top: 4, right: 4, child: _corner(topRight: true)),
          Positioned(bottom: 4, left: 4, child: _corner(bottomLeft: true)),
          Positioned(bottom: 4, right: 4, child: _corner(bottomRight: true)),
        ],
      ),
    );
  }

  Widget _corner({
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    return SizedBox(
      width: bracketLength,
      height: bracketLength,
      child: CustomPaint(
        painter: _CornerBracketPainter(
          color: kBracketColor,
          thickness: bracketThickness,
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
      ),
    );
  }
}

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  _CornerBracketPainter({
    required this.color,
    required this.thickness,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    if (topLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (topRight) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (bottomLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else if (bottomRight) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CornerBracketPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// QR PREVIEW DIALOG (opens when QR thumbnail is tapped)
// ---------------------------------------------------------------------------
class QrPreviewDialog extends StatelessWidget {
  final model.Data account;

  const QrPreviewDialog({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header banner
            Container(
              width: double.infinity,
              color: kHeaderBlue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Account Name : ${(account.accountName ?? '').split(' ').first}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            // QR code with red bracket frame
            Padding(
              padding: const EdgeInsets.all(24),
              child: BracketedQrBox(
                data: account.upiId ?? '',
                boxSize: 220,
                qrSize: 180,
                bracketLength: 26,
                bracketThickness: 3,
              ),
            ),

            // Share button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: OutlinedButton(
                onPressed: () {
                  // Hook up share_plus or your existing ShareReceipt helper here.
                  // Example:
                  // Share.share('Pay via UPI: ${account.upiId}');
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: kHeaderBlue),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                ),
                child: const Icon(Icons.share, color: kHeaderBlue, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
