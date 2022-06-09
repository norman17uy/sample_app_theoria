import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sample_app_theoria/core/network/network_info.dart';
import 'package:sample_app_theoria/features/random_image/data/repositories/image_repository_impl.dart';
import 'package:sample_app_theoria/features/random_image/domain/usecases/get_random_image.dart';
import 'package:sample_app_theoria/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/random_image/data/datasources/image_remote_data_source.dart';
import 'features/random_image/domain/repositories/image_repository.dart';

final sl = GetIt.instance;

void init() {
  // UseCase
  sl.registerLazySingleton(() => GetRandomImage(repository: sl()));

  // Repository
  sl.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerFactory(() => RandomImageBloc(sl()));

  // Data Sources
  sl.registerLazySingleton<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(
      sl(),
    ),
  );

  // Bloc

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
