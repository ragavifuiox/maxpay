import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/domain/repository/banner_repository.dart';

import 'package:maxpay/core/domain/repository/grade_repository.dart';

import 'package:maxpay/core/error/failure.dart';



class BannerUsecase {
  final BannerRepository repository;
  BannerUsecase(this.repository);
  Future<Either<Failure,Banner>> call() {
    return repository.banner();
  }
}
