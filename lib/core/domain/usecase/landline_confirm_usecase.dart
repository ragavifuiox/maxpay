import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/landline_confirm_model.dart';
import 'package:maxpay/core/domain/repository/landline_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class LandlineConfirmUsecase {
  final LandlineConfirmRepository repository;

  LandlineConfirmUsecase(this.repository);

  Future<Either<Failure, LandlineConfirmModel>> call({
    required String productdetid,
  }) async {
    return await repository.getLandlineConfirmTransaction(
      productdetid: productdetid,
    );
  }
}
