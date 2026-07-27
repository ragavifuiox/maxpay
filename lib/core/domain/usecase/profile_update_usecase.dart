import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/domain/repository/profile_repository.dart';

class ProfileUpdateUseCase {
  final ProfileRepository repository;

  ProfileUpdateUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(Map<String, dynamic> data) async {
    return await repository.updateProfile(data);
  }
}
