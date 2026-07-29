// class DioErrorHandler {
//   static ServerFailure handle(DioException e) {
//     String message = "Something went wrong";

//     if (e.response?.data is Map<String, dynamic>) {
//       message = e.response?.data["message"] ?? message;
//     } else if (e.response?.data != null) {
//       message = e.response!.data.toString();
//     } else {
//       message = e.message ?? message;
//     }

//     return ServerFailure(message: message);
//   }
// }