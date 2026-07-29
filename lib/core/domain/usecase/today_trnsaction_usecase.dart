


import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/data/model/today_trnasaction_model.dart';
import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
import 'package:maxpay/core/domain/repository/today_trnsaction_repsoitory.dart';
import 'package:maxpay/core/error/failure.dart';

class TodayTrnsactionUsecase {
  final TodayTrnsactionRepsoitory repository;
  TodayTrnsactionUsecase(this.repository);
  Future<Either<Failure, TodayTransaction>> call() {
    return repository.todaytrans();
  }
}
