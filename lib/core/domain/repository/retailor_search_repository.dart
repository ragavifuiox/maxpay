import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/retailer_search_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class RetailorSearchRepository {
  Future<Either<Failure, RetailorSearch>> searchretailor({
    required String regmob,
   
  });
}
  
