

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/today_credit_model.dart';
import 'package:maxpay/core/data/model/today_trnasaction_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TodayTrnsactionRepsoitory {
  Future<Either<Failure, TodayTransaction>> todaytrans();
}
