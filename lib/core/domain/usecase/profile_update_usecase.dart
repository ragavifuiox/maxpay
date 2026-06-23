

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ProfileUpdateUsecase  {
  final ProfileUpdateRepository repository;
  ProfileUpdateUsecase(this.repository);
  Future<Either<Failure, ProfileUpdate>> call(
    String pincode,
    String email,
    String mobilenumber,
    String name,
    String profileimage,
  ) {
    return repository.updateprofile(
     pincode:pincode,
     email:email,
     name:name,
     mobilenumber: mobilenumber,
     profileimage: profileimage
    );
  }
}
