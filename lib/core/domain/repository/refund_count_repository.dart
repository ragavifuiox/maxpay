

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/refund_count_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class RefundCountRepository {
  Future<Either<Failure, RefundCount>> refundcount();
}
