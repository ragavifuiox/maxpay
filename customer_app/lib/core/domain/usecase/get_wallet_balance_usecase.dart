import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/wallet_balance_model.dart';
import 'package:maxpay/core/domain/repository/wallet_repository.dart';

class GetWalletBalanceUseCase {
  final WalletRepository repository;

  GetWalletBalanceUseCase(this.repository);

  Future<Either<Failure, WalletBalanceModel>> call() async {
    return await repository.getWalletBalance();
  }
}
