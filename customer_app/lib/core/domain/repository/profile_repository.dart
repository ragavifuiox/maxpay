import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/model/profile_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, Map<String, dynamic>>> updateProfile(Map<String, dynamic> data);
}
