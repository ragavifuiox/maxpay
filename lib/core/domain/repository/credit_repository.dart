
import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class CreditRepository {
  Future<Either<Failure, Credit>> getCredit();
}
