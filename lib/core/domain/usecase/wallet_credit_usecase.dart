import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/data/model/wallet_credit_type_model..dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_type_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class WalletCreditTypeUsecase {
  final WalletCreditTypeRepository repository;
  WalletCreditTypeUsecase(this.repository);
  Future<Either<Failure, CreditType>> call() {
    return repository.gredittype();
  }
}
