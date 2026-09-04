import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';


import 'package:maxpay/core/error/failure.dart';

abstract class CableTvBillRepository {
  Future<Either<Failure, InstantPay>> cabletvbill({
    required String productid,
    required String consumernumber,
   
  
   
  });

  }
