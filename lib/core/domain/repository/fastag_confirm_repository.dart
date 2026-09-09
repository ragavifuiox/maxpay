import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/fastag_confirm_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class FastagConfirmRepository {
  Future<Either<Failure, FastagConfirmModel>> getFastagConfirmTransaction({
    required String productdetid,
  });
}
