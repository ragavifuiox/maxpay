import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/my_earnings_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';

import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchEarningsRepository {
  Future<Either<Failure, MyEarning>> searchEarnings({
    required String fromdate,
    required String todate,
    required String search,
   
  });
}
  
