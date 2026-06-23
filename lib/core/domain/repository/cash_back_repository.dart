

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/cash_back_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class CashBackRepository {
  Future<Either<Failure, CashBack >> cashback({
    required String producttype,
  });
}
