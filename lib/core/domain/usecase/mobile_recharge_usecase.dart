

import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/mobile_recharge.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class MobileRechargeUsecase {
  final MobileRechargeRepository repository;
  MobileRechargeUsecase(this.repository);
  Future<Either<Failure, MobileRecharge>> call(
    String productdetid,
    String mobile,
    String amount,
    String paymentstatus,
    String commission,
  ) {
    return repository.mobileRecharge(
      productdetid: productdetid,
      mobile: mobile,
      amount: amount,
      paymentstatus: paymentstatus,
      commission: commission,

    );
  }
}
