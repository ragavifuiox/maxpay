import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/fastag_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class FetchFastagBillUseCase {
  final FastagRepository repository;

  FetchFastagBillUseCase(this.repository);

  Future<Either<Failure, InstantPay>> call({
    required String productId,
    required String consumerNumber,
  }) async {
    return await repository.fetchBill(
      productId: productId,
      consumerNumber: consumerNumber,
    );
  }
}
