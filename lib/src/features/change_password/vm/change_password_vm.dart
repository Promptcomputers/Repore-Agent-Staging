import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordVM, AsyncValue<bool>>((ref) {
  return ChangePasswordVM(ref);
});

class ChangePasswordVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  ChangePasswordVM(this.ref) : super(const AsyncData(false));

  ///Change password fo rlogged in user
  void changePassword(oldPassword, newPassword, userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(profileServiceRepoProvider)
          .changePassword(oldPassword, newPassword, userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
