import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/fastag_confirm_model.dart';
import 'package:maxpay/core/domain/repository/fastag_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class FastagConfirmUsecase {
  final FastagConfirmRepository repository;

  FastagConfirmUsecase({required this.repository});

  Future<Either<Failure, FastagConfirmModel>> call({
    required String productdetid,
  }) async {
    return await repository.getFastagConfirmTransaction(
      productdetid: productdetid,
    );
  }
}
