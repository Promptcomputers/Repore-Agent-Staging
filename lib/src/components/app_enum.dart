///Ticket status
enum TicketStatusType {
  ///CREATED=>Pending, ONGOING=>Ongoing, CLOSED=>Completed ticket
  CREATED,
  ONGOING,

  CLOSED,
}

///Invoice approval status,
enum InvoiceApprovalStatus {
  PENDING,
  REJECT,
  AWAITING,
  ACCEPT,
  APPROVED,
}

///Invoice type,
enum InvoiceType {
  ACQUISITION,
  SERVICE,
}
