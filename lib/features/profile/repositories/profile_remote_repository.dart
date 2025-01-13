import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/profile/models/user.dart';
import 'package:tasky_app/features/profile/repositories/profile_local_data_source.dart';
import 'package:tasky_app/shared/error/custom_error_handler.dart';
import 'package:tasky_app/shared/error/failures.dart';
import '../../../shared/networking/api_constants.dart';
import '../../../shared/networking/connection_checker.dart';

class ProfileRemoteRepository {
  const ProfileRemoteRepository({
    required Dio dio,
    required ConnectionChecker connectionChecker,
    required ProfileLocalDataSource profileLocalDataSource,
  })  : _dio = dio,
        _connectionChecker = connectionChecker,
        _profileLocalDataSource = profileLocalDataSource;
  final Dio _dio;
  final ConnectionChecker _connectionChecker;
  final ProfileLocalDataSource _profileLocalDataSource;

  Future<Either<Failure, UserModel>> getUserProfile() async {
    try {
      if (!await (_connectionChecker.isConnected)) {
        final user = await _profileLocalDataSource.loadProfile();
        if (user == null) {
          return Left(Failure(message: 'No internet connection'));
        } else {
          return Right(user);
        }
      }
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/auth/profile',
      );
      final user = UserModel.fromJson(response.data);
      _profileLocalDataSource.uploadLocalProfile(profile: user);
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
