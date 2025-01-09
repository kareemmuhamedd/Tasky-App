import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:tasky_app/features/create_task/model/task_model.dart';
import 'package:tasky_app/shared/error/failures.dart';
import 'package:tasky_app/shared/networking/api_constants.dart';

import '../../../shared/error/custom_error_handler.dart';

class HomeRepository {
  const HomeRepository({
    required Dio dio,
  }) : _dio = dio;
  final Dio _dio;

  Future<Either<Failure, List<TaskModel>>> getTasks(int page) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/todos',
        queryParameters: {'page': page},
      );
      final tasks = (response.data as List<dynamic>)
          .map((task) => TaskModel.fromJson(task as Map<String, dynamic>))
          .toList();
      if (response.statusCode != 200) {
        return Left(Failure(message: 'Failed to fetch tasks'));
      }
      return Right(tasks);
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }

  Future<Either<Failure, TaskModel>> getSpecificTask(String taskId) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/todos/$taskId',
      );
      final task = TaskModel.fromJson(response.data as Map<String, dynamic>);
      if (response.statusCode != 200) {
        return Left(Failure(message: 'Failed to fetch tasks'));
      }
      return Right(task);
    } on DioException catch (dioError) {
      final errorMessage = CustomErrorHandler.handleDioError(dioError);
      return Left(Failure(message: errorMessage));
    } catch (error) {
      final errorMessage = CustomErrorHandler.handleError(error);
      return Left(Failure(message: errorMessage));
    }
  }
}
