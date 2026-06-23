


import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/web_login_model.dart';

import 'package:maxpay/core/data/model/web_logout_mode.dart';
import 'package:maxpay/core/domain/repository/web_logout_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WebLogoutUsecase {
  final WebLogoutRepository repository;
  WebLogoutUsecase(this.repository);
  Future<Either<Failure, WebLogout>> call(
    String isweb,
    
  ) {
    return repository.weblogout(
    isweb: isweb
     
    );
  }
}
