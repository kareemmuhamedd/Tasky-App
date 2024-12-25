import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/auth/login/model/login_response_model.dart';
import 'package:tasky_app/shared/error/failures.dart';
import 'package:tasky_app/shared/networking/api_constants.dart';

import '../../../../shared/error/custom_error_handler.dart';
import '../model/login_model.dart';

class LoginRemoteRepository {
  LoginRemoteRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, LoginResponseModel>> login(
      {required LoginModel data}) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/auth/login',
        data: data.toMap(),
      );
      if (response.statusCode != 201) {
        return Left(Failure(message: 'Something went wrong.'));
      }
      return Right(LoginResponseModel.fromMap(response.data));
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }
}
