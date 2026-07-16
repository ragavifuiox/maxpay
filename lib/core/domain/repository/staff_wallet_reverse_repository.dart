

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/staff_wallet_reverse_model.dart';
import 'package:maxpay/core/data/model/statement_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class StaffWalletReverseRepository {
  Future<Either<Failure, StaffReverse>> staffreverse({
    required String id,
  
    
    });

  }
