import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';

import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class ProfileUpdateRepository {
  Future<Either<Failure, ProfileUpdate>> updateprofile({
    required String pincode,
    required String email,
    required String mobilenumber,
    required String profileimage,
    required String name,
  });
}
  
