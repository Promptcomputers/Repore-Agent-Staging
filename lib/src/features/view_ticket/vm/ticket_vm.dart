import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final viewSingleTickets = FutureProvider.autoDispose
    .family<GetSingleTicketWithFiles, String>((ref, id) async {
  return await ref.watch(ticketServiceRepoProvider).getSingleTicket(id);
});

final getTicketMessages = FutureProvider.autoDispose
    .family<GetTicketMessages, String>((ref, ticketId) async {
  return await ref.watch(ticketServiceRepoProvider).getTicketMessages(ticketId);
});

final sendMessageProvider =
    StateNotifierProvider<SendMessageVm, AsyncValue<bool>>((ref) {
  return SendMessageVm(ref);
});

class SendMessageVm extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  SendMessageVm(this.ref) : super(const AsyncData(false));

  ///send Message
  void sendMessage(
      String filesPath, String ticketId, String userId, String message) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(ticketServiceRepoProvider)
          .sendTicketMessage(filesPath, ticketId, userId, message));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
