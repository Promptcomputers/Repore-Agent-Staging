import 'package:repore_agent/lib.dart';

abstract class ITicketServiceRepo {
  ///Get user tickets
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']);

  ///Get single tickets with fikes
  Future<GetSingleTicketWithFiles> getSingleTicket(String userId);

  ///Get ticket messages
  Future<GetTicketMessages> getTicketMessages(String tickeId);

  ///Send messages
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message);
}
