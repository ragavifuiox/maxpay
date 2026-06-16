



import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/confirm_dth_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class ConfirmDthRepository {
  Future<Either<Failure, ConfirmDth >> getdthconfirm({
    required String prodcutdetid,
  });
}
