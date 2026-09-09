import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/domain/repository/broadband_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class BroadbandConfirmUsecase {
  final BroadbandBillRepository repository;

  BroadbandConfirmUsecase(this.repository);

  Future<Either<Failure, BroadbandConfirmModel>> call({
    required String productId,
  }) {
    return repository.confirmTransaction(productId: productId);
  }
}
