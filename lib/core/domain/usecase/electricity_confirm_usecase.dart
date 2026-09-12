import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/electricity_confirm_model.dart';
import 'package:maxpay/core/domain/repository/electricity_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ElectricityConfirmUsecase {
  final ElectricityConfirmRepository repository;

  ElectricityConfirmUsecase(this.repository);

  Future<Either<Failure, ElectricityConfirmModel>> call({
    required String productId,
    required String consumerNumber,
  }) async {
    return await repository.getElectricityConfirmTransaction(
      productId: productId,
      consumerNumber: consumerNumber,
    );
  }
}
