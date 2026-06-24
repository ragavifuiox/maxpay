import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_create_qr_model.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletCreateQrRepo {
  Future<Either<Failure, CreateQrResponse>> createQr({required String amount});
  Future<Either<Failure, String>> checkQrStatus({required String txnId});
  Future<Either<Failure, WalletQrHistory>> getWalletHistory();
}
