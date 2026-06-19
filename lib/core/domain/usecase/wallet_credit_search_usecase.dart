

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_search_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WalletCreditSearchUsecase {
  final WalletCreditSearchRepository repository;
  WalletCreditSearchUsecase(this.repository);
  Future<Either<Failure,CreditList>> call({
  required String credit,
  required String fromdate,
  required String todate,
  required String search,
 
  
}) {
  return repository.searchcredit(
credit:credit,
    
fromdate:fromdate,
todate:todate,

search: search

  );
}
}

  
