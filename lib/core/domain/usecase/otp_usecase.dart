import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/otp_response_model.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';


class OtpUsecase {
  final OtpRepository repository;
  OtpUsecase(this.repository);
  Future<Either<Failure, OtpResponse>> call(
    String phoneNumber ,
    String otp ,
  
    ) {
    return repository.otp(
      phoneNumber: phoneNumber,
      otp: otp, 
   );
  }
}
