import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final loginProvider =
    StateNotifierProvider<LoginVM, AsyncValue<LoginRes>>((ref) {
  return LoginVM(ref);
});

class LoginVM extends StateNotifier<AsyncValue<LoginRes>> {
  final Ref ref;
  LoginVM(this.ref) : super(AsyncData(LoginRes()));

  void login(email, password) async {
    final messaging = FirebaseMessaging.instance;
    final deviceId = await messaging.getToken();
    // final deviceId =  Platform.isAndroid?  await messaging.getToken():await messaging.getAPNSToken();

    state = const AsyncValue.loading();
    try {
      // state = await AsyncValue.guard(() => ref
      //     .read(authServiceRepoProvider)
      //     .login(email: email, password: password, deviceToken: ''));
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .login(email: email, password: password, deviceToken: deviceId!));

      if (!state.hasError) {
        PreferenceManager.isFirstLaunch = false;
        PreferenceManager.isloggedIn = true;
        PreferenceManager.token = state.asData!.value.data!.token;
        // PreferenceManager.deviceToken = deviceId!;
        // ref
        //     .read(userProvider)
        //     .setFirstName(state.asData!.value.data!.firstname!);
        // ref.read(userProvider).setUserId(state.asData!.value.data!.id!);
        PreferenceManager.userId = state.asData!.value.data!.user!.id;
        PreferenceManager.firstName = state.asData!.value.data!.user!.firstname;

        PreferenceManager.email = state.asData!.value.data!.user!.email;
      }
    } catch (e, s) {
      log('error from loginvm $e');
      state = AsyncValue.error(e, s);
    }
  }
}
