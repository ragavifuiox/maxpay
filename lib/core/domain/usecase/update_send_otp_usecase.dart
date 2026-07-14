import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_send_otmodel.dart';
import 'package:maxpay/core/domain/repository/update_send_otp_repository.dart';
import 'package:maxpay/core/error/failure.dart';

class UpdateSendOtpUsecase {
  final UpdateSendOtpRepository repository;

  UpdateSendOtpUsecase(this.repository);

  Future<Either<Failure, SendUpdatePinOtpResponse>> call() {
    return repository.updatePin();
  }
}