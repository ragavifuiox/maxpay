import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class LandlinePayRepository {
  Future<Either<Failure, InstantPayBill>> payLandlineBill({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  });
}
