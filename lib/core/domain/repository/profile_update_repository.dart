import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/profile_update_model.dart';

import 'package:maxpay/core/error/failure.dart';


  abstract class ProfileUpdateRepository {
  Future<Either<Failure, ProfileUpdate>> updateprofile({
    required String pincode,
    required String email,
    required String mobilenumber,
    File? profileimage,
    required String name,
    required String whatsappnumber,
    required String address,
  });
}

  
