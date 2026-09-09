import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class FastagRepository {
  Future<Either<Failure, InstantPay>> fetchBill({
    required String productId,
    required String consumerNumber,
  });
}
