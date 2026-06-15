import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/add_staff_model.dart';
import 'package:maxpay/core/data/model/dispute_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class DisputeRepository {
  Future<Either<Failure, Dispute>> dispute({
    required String fromdate,
   
    required String todate,
   
   
  });

  }
