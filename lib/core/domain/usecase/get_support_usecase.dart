import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetSupportUsecase{
  final SupportRepository repository;
  GetSupportUsecase(this.repository);
  Future<Either<Failure, Support>> call() {
    return repository.getsupport();
  }
}
