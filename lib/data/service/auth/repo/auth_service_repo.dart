import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final authServiceRepoProvider = Provider<AuthServiceRepo>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthServiceRepo(authService);
});

class AuthServiceRepo extends IAUthServiceRepo {
  final AuthService _authService;
  AuthServiceRepo(this._authService);

  @override
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    return await _authService.login(
        email: email, password: password, deviceToken: deviceToken);
  }
}
