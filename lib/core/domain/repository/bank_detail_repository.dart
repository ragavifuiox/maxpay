import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/bank_details_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class BankDetailRepository {
  Future<Either<Failure, BankDetails>> bankdetail();
}
