// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
// import 'package:maxpay/core/domain/usecase/wallet_trnasfer_detail_usecase.dart';
// import 'package:maxpay/view/transfer_detail/wallet_trnasfer.dart';

// class TransferDetailController extends GetxController {
//   final WalletTrnasferDetailUsecase usecase;

//   TransferDetailController(this.usecase);

//   // ---- reactive state ----
//   final Rx<TransferFilterType?> selectedFilter = Rx<TransferFilterType?>(null);
//   final Rx<DateTime?> fromDate = Rx<DateTime?>(null);
//   final Rx<DateTime?> toDate = Rx<DateTime?>(null);
//   final RxString searchQuery = ''.obs;

//   final RxBool isLoading = false.obs;
//   final RxnString errorMessage = RxnString();
//   final Rxn<TransferData> result = Rxn<TransferData>();

//   Timer? _debounce;

//   @override
//   void onInit() {
//     super.onInit();
//     fetch();
//   }

//   @override
//   void onClose() {
//     _debounce?.cancel();
//     super.onClose();
//   }

//   String _apiDate(DateTime d) =>
//       "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

//   /// Called by the dropdown.
//   void onFilterChanged(TransferFilterType? value) {
//     selectedFilter.value = value;
//     fetch();
//   }

//   /// Called by the two date pickers.
//   void onDateRangeChanged(DateTime? from, DateTime? to) {
//     fromDate.value = from;
//     toDate.value = to;
//     fetch();
//   }

//   /// Called on every keystroke in the search field — debounced so it
//   /// doesn't hit the backend on every character.
//   void onSearchChanged(String value) {
//     searchQuery.value = value;
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), fetch);
//   }

//   Future<void> fetch() async {
//     isLoading.value = true;
//     errorMessage.value = null;

//     final response = await usecase.call(
//       selectedFilter.value?.label ?? '',
//       fromDate.value != null ? _apiDate(fromDate.value!) : '',
//       toDate.value != null ? _apiDate(toDate.value!) : '',
//       searchQuery.value,
//     );

//     response.fold(
//       (failure) {
//         isLoading.value = false;
//         errorMessage.value = failure.message;
//         result.value = null;
//       },
//       (data) {
//         isLoading.value = false;
//         result.value = data.data;
//       },
//     );
//   }

//   /// Convenience getters for the view.
//   List<TransferHistory> get history => result.value?.history ?? [];
//   double get totalAmount => double.tryParse(result.value?.totalAmount ?? '0') ?? 0.0;
//   bool get hasResults => history.isNotEmpty;
// }