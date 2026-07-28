import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/grade_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class GradeRepository {
  Future<Either<Failure, RetailorGrade>> grade();
}
