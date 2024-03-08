import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final getAallInvoiceTicketProvider = FutureProvider.autoDispose
    .family<AllTicketInvoiceRes, String>((ref, ticketId) async {
  return await ref
      .watch(invoiceServiceRepoProvider)
      .getTickeListOfInvoices(ticketId);
});

final createInvoiceProvider =
    StateNotifierProvider<CreateInvoiceVM, AsyncValue<bool>>((ref) {
  return CreateInvoiceVM(ref);
});

class CreateInvoiceVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  CreateInvoiceVM(this.ref) : super(AsyncData(true));

  void createInvoice({required CreateInvoiceReq createInvoiceReq}) async {
    // log('DeviceToken $deviceId');
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() =>
          ref.read(invoiceServiceRepoProvider).createInvoice(createInvoiceReq));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
