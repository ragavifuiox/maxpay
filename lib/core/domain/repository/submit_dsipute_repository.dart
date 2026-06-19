import 'package:dartz/dartz.dart';

import 'package:maxpay/core/data/model/search_staff_model.dart';
import 'package:maxpay/core/data/model/submit_dispute_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class SubmitDsiputeRepository {
  Future<Either<Failure, SubmitDispute>> submitdsipute({
    required String rechargeid,
    required String description,
    required String subject,

  });
}
  
