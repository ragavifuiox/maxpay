import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/broadband_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class BroadbandBillUsecase {
  final BroadbandBillRepository repository;

  BroadbandBillUsecase(this.repository);

  Future<Either<Failure, InstantPay>> call({
    required String productId,
    required String consumerNumber,
  }) {
    return repository.broadbandbill(
      productId: productId,
      consumerNumber: consumerNumber,
    );
  }
}
