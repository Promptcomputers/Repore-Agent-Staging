import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final ticketServiceRepoProvider = Provider<TicketServiceRepo>((ref) {
  final ticketService = ref.watch(ticketServiceProvider);
  return TicketServiceRepo(ticketService);
});

class TicketServiceRepo extends ITicketServiceRepo {
  final TicketService _ticketService;
  TicketServiceRepo(this._ticketService);

  @override
  Future<GetSingleTicketWithFiles> getSingleTicket(String userId) async {
    return await _ticketService.getSingleTicket(userId);
  }

  @override
  Future<GetTicketMessages> getTicketMessages(String tickeId) async {
    return await _ticketService.getTicketMessages(tickeId);
  }

  @override
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']) async {
    return await _ticketService.getUserTicket(userId);
  }

  @override
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message) async {
    return await _ticketService.sendTicketMessage(
        filesPath, ticketId, userId, message);
  }
}
