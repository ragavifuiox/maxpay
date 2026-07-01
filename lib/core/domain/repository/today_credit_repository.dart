

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TodayCreditRepository {
  Future<Either<Failure, TodayCredit>> todaycredit();
}
