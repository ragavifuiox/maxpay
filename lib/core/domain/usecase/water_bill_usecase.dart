import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/water_bill_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WaterBillUsecase {
  final WaterBillRepository repository;

  WaterBillUsecase(this.repository);

  Future<Either<Failure, InstantPay>> call({
    required String productId,
    required String customerId,
  }) {
    return repository.waterbill(productId: productId, customerId: customerId);
  }
}
