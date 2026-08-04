import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class DthRechargeRepository {
  Future<Either<Failure, DthRecharge>> Dthrecharge({
    required String productdetid,

    required String mobile,
    required String amount,
    required String paymentstatus,
    required String commission,
  });
}
