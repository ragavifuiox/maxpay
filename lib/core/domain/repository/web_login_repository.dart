
import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/data/model/web_login_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WebLoginRepository {
  Future<Either<Failure, WebLogin>> weblogin({
    required String userid,
   
    
   
  });

  }
