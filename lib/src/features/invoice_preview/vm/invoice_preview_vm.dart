import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final viewInvoiceProvider = FutureProvider.autoDispose
    .family<InvoiceDetailsRes, String>((ref, invoiceId) async {
  return await ref
      .watch(invoiceServiceRepoProvider)
      .getInvoiceDetails(invoiceId);
});

final cashOutProvider =
    StateNotifierProvider<CashOutVM, AsyncValue<bool>>((ref) {
  return CashOutVM(ref);
});

class CashOutVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  CashOutVM(this.ref) : super(const AsyncData(false));

  ///Create pin
  void cashout(String invoiceId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(paymentServiceRepoProvider).cashout(invoiceId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
