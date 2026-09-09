import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class BroadbandBillRepository {
  Future<Either<Failure, InstantPay>> broadbandbill({
    required String productId,
    required String consumerNumber,
  });

  Future<Either<Failure, BroadbandConfirmModel>> confirmTransaction({
    required String productId,
  });
}
