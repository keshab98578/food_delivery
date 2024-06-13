import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/splash/presentation/navigator/splash_navigator.dart';

final splashViewModelProvider =
    StateNotifierProvider<SplashViewModel, void>((ref) {
  final navigator = ref.read(splashViewNavigatorProvider);
  return SplashViewModel(navigator);
});

class SplashViewModel extends StateNotifier<void> {
  SplashViewModel(this.navigator) : super(null);

  final SplashViewNavigator navigator;

  //open login page
  void openLoginView() {
    Future.delayed(const Duration(seconds: 2), () {
      navigator.openLoginView();
    });
  }

  //later on we will add open home page method here as well

  void openHomeView() {}
}
