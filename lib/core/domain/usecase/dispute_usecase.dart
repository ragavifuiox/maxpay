

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/dispute_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/dispute_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class DisputeUsecase {
  final DisputeRepository repository;

  DisputeUsecase(this.repository);

  Future<Either<Failure, Dispute>> call({
    required String fromdate,
    required String todate,
    
  }) {
    return repository.dispute(
      fromdate: fromdate,
      todate: todate,
     
    );
  }
}