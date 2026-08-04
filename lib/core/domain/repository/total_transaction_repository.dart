

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/total_trnsaction.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TotalTransactionRepsoitory {
  Future<Either<Failure, TotalTransaction>> totaltrans();

}
