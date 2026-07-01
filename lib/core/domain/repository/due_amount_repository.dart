import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/data/model/due_amount_model.dart';
import 'package:maxpay/core/error/failure.dart';


abstract class DueAmountRepository {
  Future<Either<Failure, DueAmount>> Dueamount();
}
