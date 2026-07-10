

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/rehcarge_offer_model.dart';
import 'package:maxpay/core/domain/repository/offer_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/paymnet_status_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class OfferRechargeUsecase  {
  final OfferRechargeRepository repository;
  OfferRechargeUsecase(this.repository);
  Future<Either<Failure, RechargeOffer>> call(
    String mobile,
    
   
  ) {
    return repository.offer(
     mobile:mobile,
    
     
    );
  }
}
