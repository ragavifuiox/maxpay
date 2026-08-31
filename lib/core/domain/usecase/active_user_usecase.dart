

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/active_user_model.dart';
import 'package:maxpay/core/domain/repository/active_user_reposiotry.dart';
import 'package:maxpay/core/error/failure.dart';

class ActiveUserUsecase {
  final ActiveUserRepository repository;
  ActiveUserUsecase(this.repository);
  Future<Either<Failure, ActiveUser>> call(
    String isActive
  ) {
    return repository.Active(
      isActive: isActive,

    );
  }
}
