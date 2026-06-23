

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/refund_model.dart';
import 'package:maxpay/core/domain/repository/refund_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class RefundUsecase  {
  final RefundRepository repository;
  RefundUsecase(this.repository);
  Future<Either<Failure, Refund>> call(
    String todate,
    String fromdate,
    String search,
   
  ) {
    return repository.refund(
     todate:todate,
     fromdate:fromdate,
     search:search,
     
    );
  }
}
