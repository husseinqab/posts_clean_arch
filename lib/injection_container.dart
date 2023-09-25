import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_arch/core/dioHelper.dart';
import 'package:posts_clean_arch/core/generic_api_calls.dart';
import 'package:posts_clean_arch/core/httpHelper.dart';
import 'package:posts_clean_arch/core/network/network_info.dart';
import 'package:posts_clean_arch/fearutres/Kyc/data/datasources/register_striga_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/Kyc/data/repositories/register_striga_repository_impl.dart';
import 'package:posts_clean_arch/fearutres/Kyc/domain/repositories/register_striga_repository.dart';
import 'package:posts_clean_arch/fearutres/Kyc/presentation/bloc/register_striga_bloc.dart';
import 'package:posts_clean_arch/fearutres/airlines/data/datasources/airline_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/airlines/data/repositories/AirlineRepositoryImpl.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/repositories/airline_repository.dart';
import 'package:posts_clean_arch/fearutres/airlines/domain/usecases/get_all_airlines.dart';
import 'package:posts_clean_arch/fearutres/airlines/presentation/bloc/airline_bloc.dart';
import 'package:posts_clean_arch/fearutres/passengers/data/datasources/passenger_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/passengers/data/repositories/passenger_repository_impl.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/repositories/passengers_repository.dart';
import 'package:posts_clean_arch/fearutres/passengers/domain/usecases/get_passengers.dart';
import 'package:posts_clean_arch/fearutres/passengers/presentation/bloc/passengers_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/data/datasources/post_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/comment_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/post_bloc.dart';
import 'package:posts_clean_arch/fearutres/users/data/datasources/user_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/users/data/repositories/user_repository_impl.dart';
import 'package:posts_clean_arch/fearutres/users/domain/repositories/user_repository.dart';
import 'package:posts_clean_arch/fearutres/users/domain/usecases/user_usecase.dart';
import 'package:posts_clean_arch/fearutres/users/presentation/bloc/user_bloc.dart';

import 'fearutres/Kyc/domain/usecases/register_striga_usecase.dart';

final sl = GetIt.instance;

void init() {
  ///feature: Posts
  sl.registerFactory(() => PostBloc(sl()));
  sl.registerFactory(() => CommentBloc(sl()));
  //use cases
  sl.registerLazySingleton(() => GetAllPosts(postRepository: sl()));
  sl.registerLazySingleton(() => GetPostComments(postRepository: sl()));
  //repo
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(remoteDataSource: sl(), callApi: sl()));
  //data
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  ///feature: Users
  //bloc
  sl.registerFactory(() => UserBloc(getAllUsers: sl()));
  //use-case
  sl.registerLazySingleton(() => GetAllUsers(userRepository: sl()));
  //repo
  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: sl(), callApi: sl()));
  //data
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(client: sl()));

  ///feature: Airlines
  sl.registerFactory(() => AirlineBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => GetAllAirlines(airlineRepository: sl()));
  //repo
  sl.registerLazySingleton<AirlineRepository>(() => AirlineRepositoryImpl(callApi: sl(),dataSource: sl()));
  //data
  sl.registerLazySingleton<AirlineRemoteDataSource>(() => AirlineRemoteDataSourceImpl(client: sl()));

  ///feature: Passengers
  sl.registerFactory(() => PassengersBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => GetPassengers(passengersRepository: sl()));
  //repo
  sl.registerLazySingleton<PassengerRepository>(() => PassengerRepositoryImpl(callApi: sl(),remoteDataSource: sl()));
  //data
  sl.registerLazySingleton<PassengersRemoteDataSource>(() => PassengersRemoteDataSourceImpl(client: sl()));
  ///feature: RegisterStriga
  sl.registerFactory(() => RegisterInStrigaBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => RegisterInStriga(registerStrigaRepository: sl()));
  //repo
  sl.registerLazySingleton<RegisterStrigaRepository>(() => RegisterStrigaRepositoryImpl(callApi: sl(),remoteDataSource: sl()));
  //data
  sl.registerLazySingleton<RegisterStrigaDataSource>(() => RegisterStrigaDataSourceImpl(client: sl()));

  ///feature: VerifyEmail
  sl.registerFactory(() => VerifyEmailBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => VerifyEmailStriga(registerStrigaRepository: sl()));

  ///feature: VerifyPhone
  sl.registerFactory(() => VerifyPhoneBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => VerifyPhoneStriga(registerStrigaRepository: sl()));

  ///feature: UpdateData
  sl.registerFactory(() => UpdateDataBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => UpdateDataStriga(registerStrigaRepository: sl()));
  ///feature: UserInfo
  sl.registerFactory(() => UserInfoBloc(sl()));
  //usecase
  sl.registerLazySingleton(() => GetUserInfo(registerStrigaRepository: sl()));


  //core
  sl.registerFactory<RestHelper>(() => HttpHelper(client: sl()));
  sl.registerLazySingleton(() => GenericCall(networkInfo: sl()));
  // sl.registerLazySingleton<RestHelper>(() => DioHelper());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  //external
  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());


}
