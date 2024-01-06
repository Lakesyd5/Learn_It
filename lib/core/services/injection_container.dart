import 'package:get_it/get_it.dart';
import 'package:learn_it/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:learn_it/src/on_boarding/data/repos/on_boarding_repo_impl.dart';
import 'package:learn_it/src/on_boarding/domain/repos/on_boarding_repo.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/check_if_user_is_firsttimer.dart';
import 'package:learn_it/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> Onboarding
  // Business Logic

  sl..registerFactory(
    () => OnBoardingCubit(
      cacheFirstTimer: sl(),
      checkIfUserIsFirstTimer: sl(),
    ),
  )

  ..registerLazySingleton(() => CacheFirstTimer(sl()))
  ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
  ..registerLazySingleton<OnboardingRepo>(() => OnBoardingRepoImpl(sl()))
  ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(sl()))
  ..registerLazySingleton(() => prefs);
}
