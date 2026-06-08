import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/popup_message_mode.dart';
import 'package:maxpay/core/domain/repository/popup_message_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class GetPopupMessageUseCase {
  final PopupMessageRepository repository;
  GetPopupMessageUseCase(this.repository);
  Future<Either<Failure, PopupMessage>> call() {
    return repository.getPopupMessage();
  }
}
