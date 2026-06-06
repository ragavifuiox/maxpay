import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/domain/repository/trans_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class TransConfirmUseCase {
  final TransConfirmRepository repository;
  TransConfirmUseCase(this.repository,);
  Future<Either<Failure, TransConfirm>> call({required String prodcutdetid}) {
    return repository.getTransactionConfirm(prodcutdetid: prodcutdetid);
  }
}
