

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/cable_tv_bill_repository.dart';
import 'package:maxpay/core/domain/repository/check_operator_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CableTvBillUsecase {
  final CableTvBillRepository repository;
  CableTvBillUsecase(this.repository);
  Future<Either<Failure, InstantPay>> call(
    String productid,
    String consumernumber,
  ) {
    return repository.cabletvbill(
      productid: productid,
      consumernumber: consumernumber,
    );
  }
}
