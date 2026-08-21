import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';
import 'package:maxpay/controllers/homepage_controller.dart';
import 'package:maxpay/core/data/model/retailer_search_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  final HomePageController homeController = Get.find<HomePageController>();

  @override
  void initState() {
    super.initState();
    // Clear previous search data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.retailorsearch.value = null;
    });
  }

  void _performSearch() {
    String regmob = searchController.text.trim();
    if (regmob.isNotEmpty) {
      homeController.searchRetailor(regmob: regmob);
    } else {
      homeController.retailorsearch.value = null;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkbgBlack : Colors.white,
      appBar: const CommonAppBar(title: "Search"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),

            /// Search Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkplceholder
                    : const Color(0xffF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                keyboardType: TextInputType.number,
                maxLength: 10,
                onChanged: (val) {
                  if (val.trim().length == 10) {
                    _performSearch();
                  } else if (val.trim().isEmpty) {
                    homeController.retailorsearch.value = null;
                  }
                },
                onSubmitted: (_) => _performSearch(),
                decoration: InputDecoration(
                  counterText: "",
                  hintText: "Enter Mobile Number",
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),

                  filled: true,
                  fillColor: isDark ? AppColors.darkbgBlack : Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isDark
                          ? Colors.grey.shade800
                          : Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.clrPrimary,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Divider(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Obx(() {
                if (homeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final retailorSearch = homeController.retailorsearch.value;
                if (retailorSearch == null ||
                    retailorSearch.data == null ||
                    retailorSearch.data!.isEmpty) {
                  return const Center(child: Text("No transactions found"));
                }

                return ListView.separated(
                  itemCount: retailorSearch.data!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final txn = retailorSearch.data![index];
                    return TransactionCard(transactionData: txn);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Data transactionData;

  const TransactionCard({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    String statusText = transactionData.status ?? "Failed";
    Color statusColor;
    if (statusText.toLowerCase() == 'success') {
      statusColor = Colors.green;
    } else if (statusText.toLowerCase() == 'pending') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    String rechargeMode = transactionData.rechargeMode ?? "N/A";
    String shortName = rechargeMode.isNotEmpty
        ? rechargeMode[0].toUpperCase()
        : "R";

    String rawDate =
        transactionData.createdAt ?? transactionData.requestTime ?? "N/A";
    String formattedDate = rawDate;
    if (rawDate != "N/A") {
      try {
        DateTime parsedDate = DateTime.parse(rawDate);
        formattedDate = DateFormat("dd-MM-yyyy hh:mm:ss a").format(parsedDate);
      } catch (e) {
        // Fallback to raw string
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Text(
                  "Date & Time:",
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.clrPrimary,
                  child: Text(
                    shortName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rechargeMode,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Transaction No: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${transactionData.transactionId ?? 'N/A'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "Provider Ref ID : ",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black87,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${transactionData.txnId ?? transactionData.txnId ?? 'N/A'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white70 : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Text(
                  "₹ ${transactionData.amount ?? '0'}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
