import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/download_model.dart';

import 'package:maxpay/core/error/failure.dart';



abstract class DownloadRepository {
  Future<Either<Failure, Download >> getDownload({
    required String successid,
  });
}
