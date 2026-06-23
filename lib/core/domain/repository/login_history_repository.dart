import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/login_history_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/data/model/refund_model.dart';

import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class LoginHistoryRepository {
  Future<Either<Failure, LoginHistory>> loginhistory({
    required String fromdate,
    required String todate,
    required String search,
   
  });
}
  
