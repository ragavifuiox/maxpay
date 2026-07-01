

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class ProfileUpdateUsecase  {
  final ProfileUpdateRepository repository;
  ProfileUpdateUsecase(this.repository);
  Future<Either<Failure, ProfileUpdate>> call({
  required String pincode,
  required String email,
  required String mobilenumber,
  required String name,
  File? profileimage,
  required String whatsappnumber,
  required String address,
}) {
  return repository.updateprofile(
    pincode: pincode,
    email: email,
    mobilenumber: mobilenumber,
    name: name,
    profileimage: profileimage,
    whatsappnumber: whatsappnumber,
    address: address,
  );
}
}
