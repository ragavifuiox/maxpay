

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';

import 'package:maxpay/core/data/model/mobile_recharge.dart';
import 'package:maxpay/core/domain/repository/dth_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class DthRechargeUsecase {
  final DthRechargeRepository repository;
  DthRechargeUsecase(this.repository);
  Future<Either<Failure, DthRecharge>> call(
    String productdetid,
    String mobile,
    String amount,
  ) {
    return repository.Dthrecharge(
      productdetid: productdetid,
      mobile: mobile,
      amount: amount,
    );
  }
}
