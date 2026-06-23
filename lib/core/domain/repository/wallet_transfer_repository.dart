

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_transfer_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletTransferRepository {
  Future<Either<Failure, walletTransfer>> walletransfer({
    required String staffid,
    required String paymenttype,
    required String amount,
   
    });

  }
