import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_payment_status.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class UpdatePaymentStatusRepository {
  Future<Either<Failure,UpdatePaymentStatus >> udpatestatus({
  required String rechargeid,
  required String status,
});

  }
