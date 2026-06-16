import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/confirm_dth_model.dart';

import 'package:maxpay/core/domain/repository/confirm_dth_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class ConfirmDthUsecase {
  final ConfirmDthRepository repository;
  ConfirmDthUsecase(this.repository,);
  Future<Either<Failure, ConfirmDth>> call({required String prodcutdetid}) {
    return repository.getdthconfirm(prodcutdetid: prodcutdetid);
  }
}
