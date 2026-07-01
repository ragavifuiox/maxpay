


import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class TodayCreditUsecase {
  final TodayCreditRepository repository;
  TodayCreditUsecase(this.repository);
  Future<Either<Failure, TodayCredit>> call() {
    return repository.todaycredit();
  }
}
