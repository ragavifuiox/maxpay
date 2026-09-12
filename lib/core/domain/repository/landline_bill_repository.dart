import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class LandlineBillRepository {
  Future<Either<Failure, InstantPay>> landlinebill({
    required String productid,
    required String consumernumber,
  });
}
