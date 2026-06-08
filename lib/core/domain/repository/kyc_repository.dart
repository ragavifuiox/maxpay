import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/kyc_add_response.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class KycRepository {
  Future<Either<Failure, KycAddResponse>> addKyc(
    String email,
    File idProof,
    File gstNo,
    File pan,
  );
}
