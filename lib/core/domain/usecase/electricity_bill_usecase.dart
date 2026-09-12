import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/domain/repository/electricity_bill_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ElectricityBillUseCase {
  final ElectricityBillRepository electricityBillRepository;

  ElectricityBillUseCase(this.electricityBillRepository);

  Future<Either<Failure, InstantPay>> call({
    required String productid,
    required String consumernumber,
  }) async {
    return await electricityBillRepository.electricityfetchbill(
      productid: productid,
      consumernumber: consumernumber,
    );
  }
}
