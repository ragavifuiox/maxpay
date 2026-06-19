import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_credit_type_model..dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletCreditTypeRepository {
  Future<Either<Failure, CreditType>> gredittype();
}
