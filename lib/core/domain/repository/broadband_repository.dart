import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/broadband_confirm_model.dart';
import 'package:maxpay/core/data/model/instant_pay_model.dart';
import 'package:maxpay/core/data/model/instant_pay_bill_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class BroadbandBillRepository {
  Future<Either<Failure, InstantPay>> broadbandbill({
    required String productId,
    required String consumerNumber,
  });

  Future<Either<Failure, BroadbandConfirmModel>> confirmTransaction({
    required String productId,
  });

  Future<Either<Failure, InstantPayBill>> payTransaction({
    required String productId,
    required String consumerNumber,
    required String amount,
    required String reEnterAmount,
    required String enquiryReference,
    required String customerMobile,
    required String whatsappNumber,
  });
}
