import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/login_model.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/error/failure.dart';


class LoginUseCase {
  final LoginRepository repository;
  LoginUseCase(this.repository);
  Future<Either<Failure, Login>> call(
    String phoneNumber ,
    String countrycode ,
    String name ,
    String pincode
    ) {
    return repository.login(
      phoneNumber: phoneNumber,
      countrycode: countrycode, 
      name: name,
      pincode: pincode);
  }
}
