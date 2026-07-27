import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/profile_model.dart';
import 'package:maxpay/core/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, ProfileModel>> call() async {
    return await repository.getProfile();
  }
}
