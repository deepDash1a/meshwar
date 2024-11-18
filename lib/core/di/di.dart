import 'package:get_it/get_it.dart';
import 'package:meshwar/business_logic/auth_cubit/auth_cubit.dart';
import 'package:meshwar/business_logic/carpool_cubit/carpool_cubit.dart';
import 'package:meshwar/business_logic/home_cubit/home_cubit.dart';
import 'package:meshwar/business_logic/trip_cubit/trip_cubit.dart';
import 'package:meshwar/data/api/dio_helper.dart';
import 'package:meshwar/data/remote_data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:meshwar/data/remote_data_source/carpool_remote_data_source/passenger_carpool_remote_data_source/passenger_carpool_remote_data_source.dart';
import 'package:meshwar/data/remote_data_source/home_remote_data_source/home_remote_data_source.dart';
import 'package:meshwar/data/remote_data_source/trip_remote_data_source/trip_remote_data_source.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Register DioHelper
  DioHelper.init();
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  // Register AuthRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource(
        getIt<DioHelper>(),
      ));

  // Register AuthCubit with AuthRemoteDataSource dependency
  getIt.registerFactory<AuthCubit>(
      () => AuthCubit(getIt<AuthRemoteDataSource>()));

  // Register HomeRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource(
        getIt<DioHelper>(),
      ));

  // Register HomeCubit with HomeRemoteDataSource dependency
  getIt.registerFactory<HomeCubit>(
      () => HomeCubit(getIt<HomeRemoteDataSource>()));

  // Register PassengerCarpoolRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<PassengerCarpoolRemoteDataSource>(
      () => PassengerCarpoolRemoteDataSource(
            getIt<DioHelper>(),
          ));

  // Register CarpoolCubit with PassengerCarpoolRemoteDataSource dependency
  getIt.registerFactory<CarpoolCubit>(
      () => CarpoolCubit(getIt<PassengerCarpoolRemoteDataSource>()));

  // Register PassengerTripRemoteDataSource with DioHelper dependency
  getIt.registerLazySingleton<PassengerTripRemoteDataSource>(
      () => PassengerTripRemoteDataSource(
            getIt<DioHelper>(),
          ));

  // Register TripCubit with PassengerCarpoolRemoteDataSource dependency
  getIt.registerFactory<TripCubit>(
      () => TripCubit(getIt<PassengerTripRemoteDataSource>()));
}
