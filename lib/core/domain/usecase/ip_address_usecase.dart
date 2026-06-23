

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/id_address_model.dart';
import 'package:maxpay/core/data/model/payment_status_model.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/domain/repository/ip_address_repository.dart';
import 'package:maxpay/core/domain/repository/paymnet_status_repository.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class IpAddressUsecase  {
  final IpAddressRepository repository;
  IpAddressUsecase(this.repository);
  Future<Either<Failure, IpAddress>> call(
    String ipaddress,
    String city,
    String state,
    String network,
   
  ) {
    return repository.ipaddress(
      ipaddress: ipaddress,
      city: city,
      state: state,
      network: network
  
     
    );
  }
}
