

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SearchPlanUsecase  {
  final SearchPlanRepository repository;
  SearchPlanUsecase(this.repository);
  Future<Either<Failure, SearchPlan>> call(
    String planid,
    String amount,
  ) {
    return repository.searchPlans(
      planid: planid,
      amount: amount,
    );
  }
}
