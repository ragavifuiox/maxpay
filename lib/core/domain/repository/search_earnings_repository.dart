import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_earnings_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchEarningsRepository {
  Future<Either<Failure, SearchEarnings>> searchEarnings({
    required String fromdate,
    required String todate,
  });
}
   
