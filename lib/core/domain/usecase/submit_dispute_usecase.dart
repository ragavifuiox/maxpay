

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/domain/repository/submit_dsipute_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SubmitDisputeUsecase  {
  final SubmitDsiputeRepository repository;
  SubmitDisputeUsecase(this.repository);
  Future<Either<Failure, SubmitDispute>> call(
    String description,
    String subject,

    String rechargeid,
  ) {
    return repository.submitdsipute(
      description: description,
      subject: subject,
      rechargeid: rechargeid,
    );
  }
}
