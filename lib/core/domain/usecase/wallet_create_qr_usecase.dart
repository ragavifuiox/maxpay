import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_qr_history.dart';

import 'package:maxpay/core/domain/repository/wallet_create_qr_repo.dart';
import 'package:maxpay/core/data/model/wallet_create_qr_model.dart';
import 'package:maxpay/core/error/failure.dart';

class WalletCreateQrUsecase {
  final WalletCreateQrRepo repository;
  WalletCreateQrUsecase(this.repository);
  Future<Either<Failure, CreateQrResponse>> createQrAmount({
    required String amount,
  }) {
    return repository.createQr(amount: amount);
  }

  Future<Either<Failure, String>> checkQrStatus({required String txnId}) {
    return repository.checkQrStatus(txnId: txnId);
  }
  Future<Either<Failure, WalletQrHistory>> getWalletHistory() {
    return repository.getWalletHistory();
  }
}
