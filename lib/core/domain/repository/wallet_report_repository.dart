

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletReportRepository {
  Future<Either<Failure, WalletReport>> walletreport({
    required String paymenttype,
    required String fromdate,
    required String todate,
    required String search,
    
    });

  }
