

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/check_operator%20repository.dart';
import 'package:maxpay/core/error/failure.dart';

class CheckOperatorUsecase {
  final CheckOperatorRepository repository;
  CheckOperatorUsecase(this.repository);
  Future<Either<Failure, CheckOperator>> call(
    String mobile,
  ) {
    return repository.checkoperator(
      mobile: mobile,
    );
  }
}
