part of 'on_boarding_cubit.dart';

abstract class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {}

// Loading state
class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

class CheckingIfUserIsFirstTimer extends OnBoardingState {
  const CheckingIfUserIsFirstTimer();
}

// Success state
class UserCached extends OnBoardingState {
  const UserCached();
}

class OnboardingStatus extends OnBoardingState {
  const OnboardingStatus({required this.isFirstTimer});

  final bool isFirstTimer;

  @override
  List<bool> get props => [isFirstTimer];
}

// Error state
class OnboardingError extends OnBoardingState {
  const OnboardingError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
