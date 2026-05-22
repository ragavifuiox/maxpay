import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletBalanceRepository {
  Future<Either<Failure, WalletBalance>> getWalletBalance();
}
