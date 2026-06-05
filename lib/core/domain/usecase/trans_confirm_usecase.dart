import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/data/model/plan_detail_model.dart';

import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/plan_detail_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/domain/repository/trans_confirm_repository.dart';
import 'package:maxpay/core/error/failure.dart';



class TransConfirmUseCase {
  final TransConfirmRepository repository;
  TransConfirmUseCase(this.repository,);
  Future<Either<Failure, TransConfirm>> call({required String prodcutdetid}) {
    return repository.getTransactionConfirm(prodcutdetid: prodcutdetid);
  }
}
