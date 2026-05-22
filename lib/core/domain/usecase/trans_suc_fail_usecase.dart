import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class TransSucFailUsecase {
  final TransactionSucFailRepository repository;
  TransSucFailUsecase(this.repository);
  Future<Either<Failure, TransactionResponse>> call() {
    return repository.getrans();
  }
}
