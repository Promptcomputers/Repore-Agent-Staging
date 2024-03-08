import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final invoiceServiceRepoProvider = Provider<InvoiceServiceRepo>((ref) {
  final invoiceService = ref.watch(invoiceServiceProvider);
  return InvoiceServiceRepo(invoiceService);
});

class InvoiceServiceRepo extends IInvoiceServiceRepo {
  final InvoiceService _invoiceService;
  InvoiceServiceRepo(this._invoiceService);

  @override
  Future<bool> createInvoice(CreateInvoiceReq createInvoiceReq) async {
    return await _invoiceService.createInvoice(createInvoiceReq);
  }

  @override
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId) async {
    return await _invoiceService.getInvoiceDetails(invoiceId);
  }

  @override
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId) async {
    return await _invoiceService.getTickeListOfInvoices(ticketId);
  }
}
