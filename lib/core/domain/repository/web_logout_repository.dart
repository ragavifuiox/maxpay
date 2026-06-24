
import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/web_logout_mode.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class WebLogoutRepository {
  Future<Either<Failure, WebLogout>> weblogout({
    required String isweb,
   
    
   
  });

  }
