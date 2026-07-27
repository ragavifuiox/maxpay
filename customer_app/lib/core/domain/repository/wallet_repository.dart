import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/wallet_balance_model.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletBalanceModel>> getWalletBalance();
}
