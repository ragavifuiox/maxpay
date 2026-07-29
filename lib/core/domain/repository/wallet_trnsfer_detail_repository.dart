

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletTrnsferDetailRepository {
  Future<Either<Failure, WalletTransferDetail>> walletransferdetail({
    required String transfertype,
    required String startdate,
    required String todate,
    required String search,
   
    });

  }
