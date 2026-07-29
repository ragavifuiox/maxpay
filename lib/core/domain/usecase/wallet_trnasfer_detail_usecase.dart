

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/wallet_trnasfer_detail.dart';
import 'package:maxpay/core/domain/repository/wallet_trnsfer_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WalletTrnasferDetailUsecase {
  final WalletTrnsferDetailRepository repository;

  WalletTrnasferDetailUsecase(this.repository);

  Future<Either<Failure, WalletTransferDetail>> call({
    required String search,
    required String startdate,
    required String todate,
    required String transfertype,
  }) {
    return repository.walletransferdetail(
      search: search,
      startdate: startdate,
      todate: todate,
      transfertype: transfertype,
    );
  }
}