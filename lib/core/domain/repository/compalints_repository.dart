import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/compalints_model.dart';
import 'package:maxpay/core/error/failure.dart';


abstract class ComplaintsRepository {
  Future<Either<Failure, Complaints>> complaints();
}
