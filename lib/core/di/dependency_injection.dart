import 'package:get_it/get_it.dart';
import 'package:meshwar/business_logic/authentication/cubit/cubit.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/data/api/dio_helper.dart';
import 'package:meshwar/data/authentication/remote_data_source/remote_data_source.dart';
import 'package:meshwar/data/layout/remote_data_source/remote_data_source.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Initialize DioHelper
  DioHelper.init();
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  // Register AuthRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<DioHelper>()));

  // Register AuthenticationAppCubit with AuthRemoteDataSource dependency
  getIt.registerLazySingleton<AuthenticationAppCubit>(
      () => AuthenticationAppCubit(getIt<AuthRemoteDataSource>()));

  // Register LayoutRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<LayoutRemoteDataSource>(
      () => LayoutRemoteDataSource(getIt<DioHelper>()));

  // Register LayoutAppCubit with LayoutRemoteDataSource dependency
  getIt.registerLazySingleton<LayoutAppCubit>(
      () => LayoutAppCubit(getIt<LayoutRemoteDataSource>()));
}
