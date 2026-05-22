import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_usecase.dart';

class HomePageController extends GetxController {
  final GetNewsUseCase getNewsUseCase;
  final GetWalletBalanceUseCase getWalletBalanceUseCase;
  final TransSucFailUsecase transSucFailUsecase;

  HomePageController({
    required this.getNewsUseCase,
    required this.getWalletBalanceUseCase,
    required this.transSucFailUsecase,
  });

  final news = <News>[].obs;  
  Rxn<TransactionResponse> transactionData =
      Rxn<TransactionResponse>();
  final Rx<WalletBalance?> walletBalance = Rx<WalletBalance?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
    fetchWalletBalance();
  }

  Future<void> fetchNews() async {
    isLoading.value = true;

    final result = await getNewsUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar('Error', failure.message);
      },
      (data) {
        isLoading.value = false;
        news.value = [data];
      },
    );
  }
  

  Future<void> fetchWalletBalance() async {
    isLoading.value = true;

    final result = await getWalletBalanceUseCase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar('Error', failure.message);
      },
      (data) {
        isLoading.value = false;
        walletBalance.value = data;
      },
    );
  }


  Future<void> getTransactionSummary() async {
    isLoading.value = true;

    final result = await transSucFailUsecase();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (data) {
        transactionData.value = data;
      },
    );

    isLoading.value = false;
  }
}
