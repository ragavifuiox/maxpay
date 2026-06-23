

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_report_model.dart';
import 'package:maxpay/core/domain/repository/wallet_report_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WalletReportUsecase {
  final WalletReportRepository repository;
  WalletReportUsecase(this.repository);
  Future<Either<Failure,WalletReport>> call({
  required String paymenttype,
  required String fromdate,
  required String todate,
  required String search,
 
  
}) {
  return repository.walletreport(
paymenttype:paymenttype,
    
fromdate:fromdate,
todate:todate,

search: search

  );
}
}

  
