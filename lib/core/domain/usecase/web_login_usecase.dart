

import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/web_login_model.dart';

import 'package:maxpay/core/domain/repository/web_login_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class WebLoginUsecase {
  final WebLoginRepository repository;
  WebLoginUsecase(this.repository);
  Future<Either<Failure, WebLogin>> call(
    String userid,
    
  ) {
    return repository.weblogin(
    userid: userid
     
    );
  }
}
