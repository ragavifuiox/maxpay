import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/plan_tab_model.dart';
import 'package:maxpay/core/domain/repository/plan_tab_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class PlanTabUseCase {
  final PlanTabRepository repository;
  PlanTabUseCase(this.repository);
  Future<Either<Failure, PlanTab>> call() {
    return repository.getPlanTab();
  }
}
