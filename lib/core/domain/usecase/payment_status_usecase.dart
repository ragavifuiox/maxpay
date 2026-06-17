

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/paymnet_status_repository.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class PaymentStatusUsecase  {
  final PaymnetStatusRepository repository;
  PaymentStatusUsecase(this.repository);
  Future<Either<Failure, PaymentStatus>> call(
    String todate,
    String fromdate,
    String search,
   
  ) {
    return repository.paymentstatus(
     todate:todate,
     fromdate:fromdate,
     search:search,
     
    );
  }
}
