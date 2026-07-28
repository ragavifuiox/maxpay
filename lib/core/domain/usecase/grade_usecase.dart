import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/grade_model.dart';

import 'package:maxpay/core/domain/repository/grade_repository.dart';

import 'package:maxpay/core/error/failure.dart';



class GradeUsecase {
  final GradeRepository repository;
  GradeUsecase(this.repository);
  Future<Either<Failure, RetailorGrade>> call() {
    return repository.grade();
  }
}
