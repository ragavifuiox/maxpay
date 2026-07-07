import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/download_model.dart';

import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/domain/repository/downlaod_repository.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class DownloadUsecase {
  final DownloadRepository repository;
  DownloadUsecase(this.repository);
  Future<Either<Failure, Download>> call({required String successid}) {
    return repository.getDownload(successid: successid);
  }
}
