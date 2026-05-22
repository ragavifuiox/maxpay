import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class PlanUseCase {
  final PlanRepository repository;
  PlanUseCase(this.repository,);
  Future<Either<Failure, Plan>> call({required String planid}) {
    return repository.getplan(planid: planid);
  }
}
