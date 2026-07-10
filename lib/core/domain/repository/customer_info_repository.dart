

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/custoer_info_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class CustomerInfoRepository {
  Future<Either<Failure, CustomerInfo>> customerinfo({
    required String productid,
    required String customerid,
  
  
   
  });
}
  
