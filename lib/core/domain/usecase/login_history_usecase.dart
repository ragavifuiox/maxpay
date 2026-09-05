import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/login_history_model.dart';
import 'package:maxpay/core/domain/repository/login_history_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class LoginHistoryUsecase  {
  final LoginHistoryRepository repository;
  LoginHistoryUsecase(this.repository);
  Future<Either<Failure, LoginHistory>> call(
    String todate,
    String fromdate,
    String search,
   
  ) {
    return repository.loginhistory(
     todate:todate,
     fromdate:fromdate,
     search:search,
     
    );
  }
  
}
