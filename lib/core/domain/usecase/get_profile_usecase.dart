import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetProfileUseCase {
  final GetProfileRepository repository;
  GetProfileUseCase(this.repository);
  Future<Either<Failure, MyProfile>> call() {
    return repository.getProfile();
  }
}
