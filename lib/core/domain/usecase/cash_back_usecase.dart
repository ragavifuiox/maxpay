

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/cash_back_model.dart';
import 'package:maxpay/core/domain/repository/cash_back_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CashBackUsecase {
  final CashBackRepository repository;
 CashBackUsecase(this.repository);
  Future<Either<Failure, CashBack>> call({
    required String producttype,
  }) {
    return repository.cashback(producttype: producttype);
  }
}
