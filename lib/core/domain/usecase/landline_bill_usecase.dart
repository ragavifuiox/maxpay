import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/landline_bill_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class LandlineBillUseCase {
  final LandlineBillRepository repository;

  LandlineBillUseCase(this.repository);

  Future<Either<Failure, InstantPay>> call({
    required String productid,
    required String consumernumber,
  }) async {
    return await repository.landlinebill(
      productid: productid,
      consumernumber: consumernumber,
    );
  }
}
