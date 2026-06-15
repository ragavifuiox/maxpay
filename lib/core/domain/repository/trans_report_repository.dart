

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/transaction_report_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class TransReportRepository {
  Future<Either<Failure, TransactionReport>> transreport({
    required String productid,
    required String fromdate,
    required String todate,
    required String search,
    required String status,
    });

  }
