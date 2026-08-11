import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/today_trnasaction_model.dart';
import 'package:maxpay/core/data/model/total_trnsaction.dart';
import 'package:maxpay/core/domain/repository/today_trnsaction_repsoitory.dart';
import 'package:maxpay/core/domain/repository/total_transaction_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class TotalTransactionUsecase {
  final TotalTransactionRepsoitory repository;
  TotalTransactionUsecase(this.repository);
  Future<Either<Failure, TotalTransaction>> call() {
    return repository.totaltrans();
  }
}
