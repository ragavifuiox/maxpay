

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/id_address_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class IpAddressRepository {
  Future<Either<Failure, IpAddress>> ipaddress({
    required String ipaddress,
    required String city,
    required String state,
    required String network,
   
  });
}
  
