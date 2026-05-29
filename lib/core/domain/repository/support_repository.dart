import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SupportRepository {
  Future<Either<Failure, Support>> getsupport();
}
