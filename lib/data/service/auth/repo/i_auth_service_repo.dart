import 'package:repore_agent/lib.dart';

abstract class IAUthServiceRepo {
  ///Login
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken});
}
