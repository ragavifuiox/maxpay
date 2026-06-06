import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class EarningsRepository {
  Future<Either<Failure, Earnings>> getEarnings();
}
