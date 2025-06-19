import 'package:auvent_flutter_internship_assessment/core/local/hive_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home_screen/data/datasources/home_local_data_source.dart';
import '../../features/home_screen/data/datasources/home_remote_data_source.dart';
import '../../features/home_screen/data/models/home_item_model.dart';
import '../../features/home_screen/data/repositories/home_repository_impl.dart';
import '../../features/home_screen/domain/repositories/home_repository.dart';
import '../../features/home_screen/domain/usecases/get_ads_usecase.dart';
import '../../features/home_screen/domain/usecases/get_restaurants_usecase.dart';
import '../../features/home_screen/domain/usecases/get_services_usecase.dart';
import '../../features/home_screen/prsentation/bloc/home_bloc.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //Hive Boxes
  final servicesBox = await HiveHelper.init<HomeItemModel>(
    'servicesBox',
    adapter: HomeItemModelAdapter(),
  );

  final restaurantsBox = await HiveHelper.init<HomeItemModel>(
    'restaurantsBox',
    adapter: HomeItemModelAdapter(),
  );

  final adsBox = await HiveHelper.init<HomeItemModel>(
    'adsBox',
    adapter: HomeItemModelAdapter(),
  );

  // Register Hive boxes
  sl.registerLazySingleton<HiveHelper<HomeItemModel>>(() => servicesBox,
      instanceName: 'services');
  sl.registerLazySingleton<HiveHelper<HomeItemModel>>(() => restaurantsBox,
      instanceName: 'restaurants');
  sl.registerLazySingleton<HiveHelper<HomeItemModel>>(() => adsBox,
      instanceName: 'ads');

  // Local data sources
  sl.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(
        servicesBox: sl<HiveHelper<HomeItemModel>>(instanceName: 'services'),
        restaurantsBox:
            sl<HiveHelper<HomeItemModel>>(instanceName: 'restaurants'),
        adsBox: sl<HiveHelper<HomeItemModel>>(instanceName: 'ads'),
      ));

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      signupUseCase: sl<SignupUseCase>(),
    ),
  );
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getServicesUseCase: sl<GetServicesUseCase>(),
      getAdsUseCase: sl<GetAdsUseCase>(),
      getRestaurantsUseCase: sl<GetRestaurantsUseCase>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<GetServicesUseCase>(
      () => GetServicesUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton<GetAdsUseCase>(
      () => GetAdsUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton<GetRestaurantsUseCase>(
      () => GetRestaurantsUseCase(sl<HomeRepository>()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl<HomeRemoteDataSource>(),
      localDataSource: sl<HomeLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  //Remote Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      firestore: sl<FirebaseFirestore>(),
      storage: sl<FirebaseStorage>(),
      firebaseAuth: sl<FirebaseAuth>(),
    ),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<InternetConnection>()));
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
