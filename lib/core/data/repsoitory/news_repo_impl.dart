// import 'package:dartz/dartz.dart';
// import 'package:maxpay/core/constants/api_routes.dart';
// import 'package:maxpay/core/data/model/news_model.dart';
// import 'package:maxpay/core/domain/repository/news_repository.dart';
// import 'package:maxpay/core/error/failure.dart';
// import 'package:maxpay/core/services/api_services.dart';


// class GetNewsRepoImpl implements GetNewsRepository {
//   final ApiService apiService;
//   GetNewsRepoImpl(this.apiService);

//   @override
//   Future<Either<Failure, News>> getNews() async {
//     try {
//       final response = await apiService.get(ApiRoutes.news);
//       final model = News.fromJson(response);
//       return Right(model);
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maxpay/core/constants/api_routes.dart';
import 'package:maxpay/core/data/model/news_model.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/services/api_services.dart';

class GetNewsRepoImpl implements GetNewsRepository {
  final ApiService apiService;

  GetNewsRepoImpl(this.apiService);

  @override
  Future<Either<Failure, News>> getNews() async {
    try {
      final response = await apiService.get(ApiRoutes.news);

      final model = News.fromJson(response);

      return Right(model);
    } on DioException catch (e) {
      print("STATUS CODE : ${e.response?.statusCode}");
      print("ERROR DATA  : ${e.response?.data}");
      print("MESSAGE     : ${e.message}");

      return Left(
        ServerFailure(
          message: e.response?.data["message"] ??
              e.message ??
              "Something went wrong",
        ),
      );
    } catch (e) {
      print("UNKNOWN ERROR : $e");

      return Left(
        ServerFailure(message: e.toString()),
      );
    }
  }
}