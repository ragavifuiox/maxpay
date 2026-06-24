import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class BannerRepository {
  Future<Either<Failure, Banner>> banner();
}
