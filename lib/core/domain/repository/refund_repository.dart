import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/refund_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class RefundRepository {
  Future<Either<Failure, Refund>> refund({
    required String fromdate,
    required String todate,
    required String search,
   
  });
}
  
