import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/cable_tv_confirm_model.dart';
import 'package:maxpay/core/domain/repository/cable_tv_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CableTvConfirmUsecase {
  final CableTvConfirmRepository repository;

  CableTvConfirmUsecase({required this.repository});
  Future<Either<Failure, CableTvConfirmModel>> getCableTvConfirm({
    required String productdetid,
  }) {
    return repository.getCableTvConfirmTransaction(productdetid: productdetid);
  }
}
