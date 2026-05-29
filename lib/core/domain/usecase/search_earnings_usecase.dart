

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/create_pin_model.dart';
import 'package:maxpay/core/data/model/search_earnings_model.dart';
import 'package:maxpay/core/data/model/wallet_request_model.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/search_earnings_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_request_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class SearchEarningsUsecase {
  final SearchEarningsRepository repository;
  SearchEarningsUsecase(this.repository);
  Future<Either<Failure, SearchEarnings>> call({
  required String fromdate,
  required String todate,
}) {
  return repository.searchEarnings(
    fromdate: fromdate,
    todate: todate,
  );
}
}

 
 
  
