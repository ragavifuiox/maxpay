import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/transaction_suc_faii_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TransactionSucFailRepository {
  Future<Either<Failure, TransactionResponse>> getrans();
}
