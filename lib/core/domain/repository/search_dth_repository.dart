import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';

import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SearchDthRepository {
  Future<Either<Failure, SearchDth>> searchdth({
    required String planid,
    required String amount,
  });
}
  
