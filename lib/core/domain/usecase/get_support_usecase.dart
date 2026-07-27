import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';

class GetSupportUseCase {
  final SupportRepository repository;

  GetSupportUseCase(this.repository);

  Future<Either<Failure, SupportModel>> call() async {
    return await repository.getSupport();
  }
}
