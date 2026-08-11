import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/active_user_model.dart';

import 'package:maxpay/core/error/failure.dart';

abstract class ActiveUserRepository {
  Future<Either<Failure, ActiveUser>> Active({
    required String isActive
   

   
  });

  }
