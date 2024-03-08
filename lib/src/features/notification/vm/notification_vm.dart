import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final getNofificationProvider =
    FutureProvider.autoDispose<GetNotificationRes>((ref) async {
  return await ref.watch(profileServiceProvider).getNotification();
});

final markNotificationAsRedProvider =
    StateNotifierProvider<MarkNotificationAsReadVM, AsyncValue<bool>>((ref) {
  return MarkNotificationAsReadVM(ref);
});

class MarkNotificationAsReadVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  MarkNotificationAsReadVM(this.ref) : super(const AsyncData(true));

  ///Create ticket
  void markNotificationAsRead(String id) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(profileServiceProvider).markNotificationAsRead(id));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final markAllNotificationProvider =
    StateNotifierProvider<MarkAllNotificationAsReadVM, AsyncValue<bool>>((ref) {
  return MarkAllNotificationAsReadVM(ref);
});

class MarkAllNotificationAsReadVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  MarkAllNotificationAsReadVM(this.ref) : super(const AsyncData(true));

  ///Mark all
  void markAllNotificationAsRead() async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(profileServiceProvider).markNotificationAllRead());
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
