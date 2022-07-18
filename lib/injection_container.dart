
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean_arch/core/network/network_info.dart';
import 'package:posts_clean_arch/fearutres/posts/data/datasources/post_remote_datasource.dart';
import 'package:posts_clean_arch/fearutres/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/comment_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;


void init() {
  //bloc
  sl.registerFactory(() => PostBloc(sl()));
  sl.registerFactory(() => CommentBloc(sl()));
  //use cases
  sl.registerLazySingleton(() => GetAllPosts(postRepository: sl()));
  sl.registerLazySingleton(() => GetPostComments(postRepository: sl()));
  //repo
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(remoteDataSource: sl(),networkInfo: sl()));
  //data
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(client: sl()));

  //core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));
  //external
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}