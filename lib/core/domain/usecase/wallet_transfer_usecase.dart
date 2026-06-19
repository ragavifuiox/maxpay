

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/data/model/wallet_transfer_model.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/domain/repository/submit_dsipute_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_transfer_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WalletTransferUsecase  {
  final WalletTransferRepository repository;
  WalletTransferUsecase(this.repository);
  Future<Either<Failure, walletTransfer>> call(
    String staffid,
    String paymenttype,

    String amount,
  ) {
    return repository.walletransfer(staffid: staffid, paymenttype: paymenttype, amount: amount);
  }
}
