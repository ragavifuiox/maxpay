
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/wallet_trnasfer_detail_controller.dart';
import 'package:maxpay/core/constants/asset_images.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/core/di/service_locator.dart';
import 'package:maxpay/core/utils/texthelper.dart';
import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

class TransferdetailFilter extends StatelessWidget {
  final TransferFilterType? selectedFilter;
  final ValueChanged<TransferFilterType?> onFilterChanged;
  final ValueChanged<String>? onSearchChanged;

  TransferdetailFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.onSearchChanged,
  });

  final WalletTrnasferDetailController controller =
      Get.find<WalletTrnasferDetailController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark
              ? AppColors.darkFilterBorder
              : AppColors.totalborde2.withValues(alpha: 0.2),
        ),
      ),
      child: 
     Column(
  children: [

    /// DATE RANGE
    Row(
      children: [

        Expanded(
          child: GestureDetector(
            onTap: () => controller.selectFromDate(context),
            child: AbsorbPointer(
              child: Container(
                height: 45,
                child: TextFormField(
                  controller: controller.fromDateController,
                  decoration: InputDecoration(
                    hintText: "DD.MM.YYYY",
                     hintStyle: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),


        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Icon(
            Icons.arrow_forward,
            color: Color(0xff17345F),
            size: 30,
          ),
        ),


        Expanded(
          child: GestureDetector(
            onTap: () => controller.selectToDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller.toDateController,
                decoration: InputDecoration(
                  hintText: "DD.MM.YYYY",
                  hintStyle: TextHelper.max1.copyWith(
          color: isDark
              ? AppColors.textclr
              : theme.colorScheme.onSurfaceVariant,
        ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),


    const SizedBox(height: 14),
    /// TRANSACTION TYPE
    DropdownButtonFormField<TransferFilterType>(

      value: selectedFilter,

      isExpanded: true,

      icon: const Icon(
        Icons.keyboard_arrow_down,
        size: 30,
      ),

      decoration: InputDecoration(

        hintText: "Transaction Type",
        
        filled: true,

        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

      ),


      items: TransferFilterType.values
          .map(
            (e)=>DropdownMenuItem(
              value:e,
              child:Text(e.label),
            ),
          )
          .toList(),

onChanged:(value) {

  if(value == null) return;

  onFilterChanged(value);

  controller.selectedFilter.value = value;

  controller.transactionType.value = value.label;


  // API CALL IMMEDIATELY
  controller.getWalletTransferDetail(
    search: controller.search.value,
    startDate: controller.fromDate,
    endDate: controller.toDate,
    transferType: controller.transactionType.value,
  );

},

    ),

 const SizedBox(height: 14),



    /// SEARCH BOX
    TextField(
      onChanged: (value) {

        controller.search.value = value;

        if(onSearchChanged != null){
          onSearchChanged!(value);
        }

      },
      decoration: InputDecoration(

        hintText: "Search",

        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),

        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            AssetImages.search,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Colors.grey,
              BlendMode.srcIn,
            ),
          ),
        ),

        filled: true,
        fillColor: Colors.white,

        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

      ),
    ),



    const SizedBox(height: 14),



    
    


  ],
)
    );
  }
}