import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  // final authRepository = ref.watch(authManagerProvider);

  return AuthController();
});

class AuthController extends StateNotifier<bool> {
  AuthController() : super(PreferenceManager.isFirstLaunch);

  void getAuth() {
    state = PreferenceManager.isFirstLaunch;
  }

  void setAuth(bool value) async {
    state = value;
  }
}
