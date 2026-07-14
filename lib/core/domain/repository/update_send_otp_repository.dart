import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/update_send_otmodel.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class UpdateSendOtpRepository {
  Future<Either<Failure, SendUpdatePinOtpResponse>> updatePin();
}