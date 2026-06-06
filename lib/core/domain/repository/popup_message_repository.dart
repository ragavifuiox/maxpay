import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class PopupMessageRepository {
  Future<Either<Failure, PopupMessage>> getPopupMessage();
}
