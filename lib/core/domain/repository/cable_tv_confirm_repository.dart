import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/cable_tv_confirm_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class CableTvConfirmRepository {
  Future<Either<Failure, CableTvConfirmModel>> getCableTvConfirmTransaction({
    required String productdetid,
  });
}
