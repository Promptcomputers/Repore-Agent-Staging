import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final changePasswordFirstTimeProvider =
    StateNotifierProvider<ChangePasswordFirstTimeVM, AsyncValue<bool>>((ref) {
  return ChangePasswordFirstTimeVM(ref);
});

class ChangePasswordFirstTimeVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  ChangePasswordFirstTimeVM(this.ref) : super(const AsyncData(false));

  ///Change password fo rlogged in user
  void changePasswordFirstTime(password, userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(profileServiceRepoProvider)
          .changePasswordFirstTime(password, userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final updateProfileInfoProvider =
    StateNotifierProvider<UpdateProfileInfoVM, AsyncValue<bool>>((ref) {
  return UpdateProfileInfoVM(ref);
});

class UpdateProfileInfoVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  UpdateProfileInfoVM(this.ref) : super(const AsyncData(false));

  ///Change password fo rlogged in user
  void updateProfileInfo(
      String userId, UpdateProfileReq updateProfileReq) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(profileServiceRepoProvider)
          .updateProfile(userId, updateProfileReq));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final createPinProvider =
    StateNotifierProvider<CrearePinVM, AsyncValue<bool>>((ref) {
  return CrearePinVM(ref);
});

class CrearePinVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  CrearePinVM(this.ref) : super(const AsyncData(false));

  ///Create pin
  void createPin(String pin) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(profileServiceRepoProvider).setPin(pin));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
