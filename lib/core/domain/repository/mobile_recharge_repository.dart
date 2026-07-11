
import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/mobile_recharge.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class MobileRechargeRepository {
  Future<Either<Failure, MobileRecharge>> mobileRecharge({
    required String productdetid,
   
    required String mobile,
    required String amount,
    required String paymentstatus
   
  });

  }
