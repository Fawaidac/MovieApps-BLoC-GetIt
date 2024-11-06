import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:getit/services/cubit/auth_cubit.dart';
import 'package:getit/services/cubit/detail_movie_cubit.dart';
import 'package:getit/services/cubit/popular_movie_cubit.dart';
import 'package:getit/services/cubit/search_movie_cubit.dart';
import 'package:getit/services/cubit/top_rated_movie_cubit.dart';
import 'package:getit/services/cubit/upcoming_movie_cubit.dart';
import 'package:getit/services/helper/database_helper.dart';
import 'package:getit/services/repository/auth_repository.dart';
import 'package:getit/services/repository/movie_repository.dart';
import 'package:getit/services/repository/search_repository.dart';
import 'package:getit/utils/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getit/ui/auth/login/login.dart';
import 'package:getit/ui/auth/register/register.dart';
import 'package:getit/ui/home/home.dart';
import 'package:getit/ui/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

Future<void> setupDependencies() async {
  final getIt = GetIt.instance;

  final prefs = await SharedPreferences.getInstance();

  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper.instance);

  getIt.registerSingleton<AuthRepository>(
    AuthRepository(databaseHelper: getIt<DatabaseHelper>()),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepository(
      apiUrl: ApiConfig.apiUrl,
      token: ApiConfig.token,
    ),
  );

  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepository(
      apiUrl: ApiConfig.apiSearchUrl,
      token: ApiConfig.token,
    ),
  );

  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt<AuthRepository>(), prefs));
  getIt.registerFactory<TopRatedMovieCubit>(
    () => TopRatedMovieCubit(getIt<MovieRepository>()),
  );
  getIt.registerFactory<PopularMovieCubit>(
    () => PopularMovieCubit(getIt<MovieRepository>()),
  );
  getIt.registerFactory<UpcomingMovieCubit>(
    () => UpcomingMovieCubit(getIt<MovieRepository>()),
  );
  getIt.registerFactory<SearchMovieCubit>(
    () => SearchMovieCubit(getIt<SearchRepository>()),
  );
  getIt.registerFactory<DetailMovieCubit>(
    () => DetailMovieCubit(getIt<MovieRepository>()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<AuthCubit>()),
        BlocProvider(create: (_) => GetIt.I<TopRatedMovieCubit>()),
        BlocProvider(create: (_) => GetIt.I<PopularMovieCubit>()),
        BlocProvider(create: (_) => GetIt.I<UpcomingMovieCubit>()),
        BlocProvider(create: (_) => GetIt.I<SearchMovieCubit>()),
        BlocProvider(create: (_) => GetIt.I<DetailMovieCubit>()),
      ],
      child: MaterialApp(
        title: 'FlickNite GetIt',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/splash',
        debugShowCheckedModeBanner: false,
        routes: {
          '/splash': (context) => Splash(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/home': (context) => Home(),
        },
      ),
    );
  }
}
