import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/earnings_mdoel.dart';
import 'package:maxpay/core/data/model/gredit_model.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/wallet_balance.dart';
import 'package:maxpay/core/domain/repository/credit_repository.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetCreditUseCase {
  final CreditRepository repository;
  GetCreditUseCase(this.repository);
  Future<Either<Failure, Credit>> call() {
    return repository.getCredit();
  }
}
