import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/landline_confirm_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class LandlineConfirmRepository {
  Future<Either<Failure, LandlineConfirmModel>> getLandlineConfirmTransaction({
    required String productdetid,
  });
}
