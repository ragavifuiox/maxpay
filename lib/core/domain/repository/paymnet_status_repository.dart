import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class PaymnetStatusRepository {
  Future<Either<Failure, PaymentStatus>> paymentstatus({
    required String fromdate,
    required String todate,
    required String search,
   
  });
}
  
