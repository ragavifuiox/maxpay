import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_request_model.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletRequestRepository {
  Future<Either<Failure, WalletRequest>> walletRequest({
    required String amount,
    required String paymenttype,
    required String utrno,
    required String bankid,
    required String description,
    required String receipt,
    });

  }
