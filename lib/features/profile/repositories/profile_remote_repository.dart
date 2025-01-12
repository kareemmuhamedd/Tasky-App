import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/profile/models/user.dart';
import 'package:tasky_app/shared/error/custom_error_handler.dart';
import 'package:tasky_app/shared/error/failures.dart';

import '../../../shared/networking/api_constants.dart';

class ProfileRemoteRepository {
  const ProfileRemoteRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/auth/profile',
      );
      final user = UserModel.fromJson(response.data);
      return Right(user);
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }

  Future<Either<Failure, bool>> logout(String refreshToken) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/auth/logout',
        data: {
          'token': refreshToken,
        },
      );
      print(response.data['success']);
      return const Right(true);
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }
}
