import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/get_profile_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class GetProfileRepository {
  Future<Either<Failure, MyProfile>> getProfile();
}
