import 'package:dartz/dartz.dart';
import 'package:maxpay/core/data/model/graph_model.dart';
import 'package:maxpay/core/error/failure.dart';

abstract class GraphRepository {
  Future<Either<Failure, Graph>> graph();
}
