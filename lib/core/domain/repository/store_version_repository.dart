import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/store_version_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class StoreVersionRepository {
  Future<Either<Failure, StoreVersionModel>> storeVersion({
    required String version,
  });
}
