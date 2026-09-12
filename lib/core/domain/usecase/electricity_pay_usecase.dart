import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/domain/repository/electricity_pay_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ElectricityPayUsecase {
  final ElectricityPayRepository repository;

  ElectricityPayUsecase(this.repository);

  Future<Either<Failure, InstantPayBill>> call({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) async {
    return await repository.electricityPayTransaction(
      productId: productId,
      consumerNumber: consumerNumber,
      amount: amount,
      reEnterAmount: reEnterAmount,
      enquiryReference: enquiryReference,
      customerMobile: customerMobile,
      whatsappNumber: whatsappNumber,
    );
  }
}
