import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/domain/repository/broadband_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class BroadbandPayUsecase {
  final BroadbandBillRepository repository;

  BroadbandPayUsecase(this.repository);

  Future<Either<Failure, InstantPayBill>> call({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  }) {
    return repository.payTransaction(
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
