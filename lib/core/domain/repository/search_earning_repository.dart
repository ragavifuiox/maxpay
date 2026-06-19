import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/my_earnings_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class SearchEarningsRepository {
  Future<Either<Failure, SearchEarning>> searchEarnings({
    required String fromdate,
    required String todate,
    required String search,
   
  });
}
  
