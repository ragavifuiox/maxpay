import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/rehcarge_offer_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class OfferRechargeRepository {
  Future<Either<Failure, RechargeOffer>> offer({
    required String mobile,
  
  
   
  });
}
  
