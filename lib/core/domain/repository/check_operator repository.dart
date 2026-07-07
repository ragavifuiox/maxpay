import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/check_operator_model.dart';


import 'package:maxpay/core/error/failure.dart';

abstract class CheckOperatorRepository {
  Future<Either<Failure, CheckOperator>> checkoperator({
    required String mobile,
   
  
   
  });

  }
