import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';

class LogoutUseCase {
  final LoginRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call() async {
    return await repository.logout();
  }
}
