import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WaterBillRepository {
  Future<Either<Failure, InstantPay>> waterbill({
    required String productId,
    required String customerId,
  });
}
