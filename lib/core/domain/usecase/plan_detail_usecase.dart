import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/plan_detail_model.dart';

import 'package:maxpay/core/domain/repository/plan_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class PlanDetailUseCase {
  final PlanDetailRepository repository;
  PlanDetailUseCase(this.repository,);
  Future<Either<Failure, PlanDetail>> call({required String planId}) {
    return repository.getplandetail(planid: planId);
  }
}
