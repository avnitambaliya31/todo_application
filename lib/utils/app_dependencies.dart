
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:todo_application/features/api_client/dio_client.dart';
import 'package:todo_application/features/presentation/repository/todo_repo/todo_repository.dart';
import 'package:todo_application/features/presentation/repository/todo_repo/todo_repository_impl.dart';

final GetIt _getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  _getIt.registerSingleton<Logger>(Logger());

  // DIO HTTP Client
  _getIt.registerSingleton<Dio>(DioClient().getDio());

  // Authentication
  _getIt.registerSingleton<TodoRepository>(TodoRepositoryImpl());


}
