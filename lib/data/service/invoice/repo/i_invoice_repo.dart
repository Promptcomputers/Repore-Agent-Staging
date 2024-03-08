import 'package:repore_agent/lib.dart';

abstract class IInvoiceServiceRepo {
  ///Get all invoice for a ticket
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId);

  ///Get invoice details and preview
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId);

  ///Create an invoice for a ticket
  Future<bool> createInvoice(CreateInvoiceReq createInvoiceReq);
}
