import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/advertisement_model.dart';
import 'package:maxpay/core/domain/repository/advertisement_repository.dart';


import 'package:maxpay/core/error/failure.dart';



class AdvertisementUsecase {
  final AdvertisementRepository repository;
  AdvertisementUsecase(this.repository);
  Future<Either<Failure,Advertisement>> call() {
    return repository.getadv();
  }
}
