

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/custoer_info_model.dart';
import 'package:maxpay/core/domain/repository/customer_info_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CustomerInfoUsecase  {
  final CustomerInfoRepository repository;
  CustomerInfoUsecase(this.repository);
  Future<Either<Failure, CustomerInfo>> call(
    String productid,
    String customerid,
  
   
  ) {
    return repository.customerinfo(
     productid:productid,
     customerid:customerid,
     
    );
  }
}
