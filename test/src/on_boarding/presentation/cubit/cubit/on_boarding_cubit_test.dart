import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:learn_it/src/on_boarding/domain/usecases/check_if_user_is_firsttimer.dart';
import 'package:learn_it/src/on_boarding/presentation/cubit/cubit/on_boarding_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit onBoardingCubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    onBoardingCubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  test('initial state should be [OnbordingInitial]', () async {
    expect(onBoardingCubit.state, OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, UserCached] when successful.',
      build: () => OnBoardingCubitBloc(),
      act: (bloc) => bloc.add(MyEvent),
      expect: () => const <OnBoardingCubitState>[MyState],
    );
   });
}
