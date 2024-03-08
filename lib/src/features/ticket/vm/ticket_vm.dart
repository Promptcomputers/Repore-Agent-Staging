import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final searchTicketProvider = StateNotifierProvider.autoDispose<GetTicketsVM,
    AsyncValue<GetUserTicketsRes>>((ref) {
  return GetTicketsVM(ref, PreferenceManager.userId);
});

class GetTicketsVM extends StateNotifier<AsyncValue<GetUserTicketsRes>> {
  final Ref ref;
  final String userId;
  GetTicketsVM(this.ref, this.userId) : super(AsyncData(GetUserTicketsRes())) {
    getTicket(userId);
  }

  ///Search ticket
  void getTicket(String userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(ticketServiceRepoProvider).getUserTicket(userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  ///Search ticket
  void searchTicket(String userId, [search = '']) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() =>
          ref.read(ticketServiceRepoProvider).getUserTicket(userId, search));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
