import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/electricity_confirm_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class ElectricityConfirmRepository {
  Future<Either<Failure, ElectricityConfirmModel>>
  getElectricityConfirmTransaction({
    required String productId,
    required String consumerNumber,
  });
}
