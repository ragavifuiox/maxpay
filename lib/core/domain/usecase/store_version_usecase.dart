import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/store_version_model.dart';
import 'package:maxpay/core/domain/repository/store_version_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class StoreVersionUsecase {
  final StoreVersionRepository repository;

  StoreVersionUsecase(this.repository);

  Future<Either<Failure, StoreVersionModel>> call({
    required String version,
  }) async {
    return await repository.storeVersion(version: version);
  }
}
