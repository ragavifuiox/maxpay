import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class UpdateFingerprintUseCase {
  final LoginRepository repository;

  UpdateFingerprintUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(int status) async {
    return await repository.updateFingerprint(status);
  }
}
