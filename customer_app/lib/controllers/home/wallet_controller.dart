import 'package:get/get.dart';
import 'package:maxpay/core/data/model/wallet_balance_model.dart';
import 'package:maxpay/core/domain/usecase/get_wallet_balance_usecase.dart';

class WalletController extends GetxController {
  final GetWalletBalanceUseCase getWalletBalanceUseCase;

  WalletController({required this.getWalletBalanceUseCase});

  final walletData = Rxn<WalletBalanceModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
  }

  Future<void> getWalletBalance() async {
    isLoading.value = true;
    final result = await getWalletBalanceUseCase();
    result.fold(
      (failure) {
        // Handle error silently or show a toast
      },
      (success) {
        walletData.value = success;
      },
    );
    isLoading.value = false;
  }
}
