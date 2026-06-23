

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/data/model/wallet_credit_model.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class StatementRepository {
  Future<Either<Failure, Statement>> statement({
    required String type,
    required String fromdate,
    required String todate,
    required String search,
    
    });

  }
