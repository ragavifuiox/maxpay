import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/advertisement_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class AdvertisementRepository {
  Future<Either<Failure, Advertisement>> getadv();
}
