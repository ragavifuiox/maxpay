

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WalletCreditSearchRepository {
  Future<Either<Failure, CreditList>> searchcredit({
    required String credit,
    required String fromdate,
    required String todate,
    required String search,
    
    });

  }
