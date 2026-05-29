import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/get_bank_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class GetBankRepository {
  Future<Either<Failure, Bank>> getbank();
}
