import 'package:flutter/material.dart';
import 'package:repore_agent/lib.dart';

///Text color for ticket screen
Color textColor(String status) {
  if (status == TicketStatusType.CREATED.name) {
    return AppColors.blackColor;
  }
  if (status == TicketStatusType.ONGOING.name) {
    return AppColors.notificationReadCardColor;
  }
  if (status == TicketStatusType.CLOSED.name) {
    return AppColors.blackColor;
  }

  return AppColors.blackColor;
}

///Cards background color for ticket
Color ticketBgColor(String status) {
  if (status == TicketStatusType.CREATED.name) {
    return AppColors.pendingBgColor;
  }
  if (status == TicketStatusType.ONGOING.name) {
    return AppColors.onGoingBgColor;
  }
  if (status == TicketStatusType.CLOSED.name) {
    return AppColors.completedBgColor;
  }

  return AppColors.allBgColor;
}

///Status text color on ticket card
Color statusTextColor(String status) {
  if (status == TicketStatusType.CREATED.name) {
    return AppColors.primaryTextColor;
  }
  if (status == TicketStatusType.ONGOING.name) {
    return AppColors.warningTextColor;
  }
  if (status == TicketStatusType.CLOSED.name) {
    return AppColors.successTextColor;
  }

  return AppColors.redColor;
}

///status text container background color
Color statusBgColor(String status) {
  if (status == TicketStatusType.CREATED.name) {
    return AppColors.whiteColor;
  }
  if (status == TicketStatusType.ONGOING.name) {
    return AppColors.warningColor;
  }
  if (status == TicketStatusType.CLOSED.name) {
    return AppColors.successBgColor;
  }
  return AppColors.whiteColor;
}

///Invoice status text color
Color invoiceStatusColor(String status) {
  if (status == InvoiceApprovalStatus.PENDING.name) {
    return AppColors.primaryTextColor;
  }
  if (status == InvoiceApprovalStatus.REJECT.name) {
    return AppColors.redColor;
  }
  if (status == InvoiceApprovalStatus.ACCEPT.name) {
    return AppColors.successTextColor;
  }

  return AppColors.primaryTextColor;
}

///Invoice status text
String statusText(String status) {
  if (status == InvoiceApprovalStatus.PENDING.name) {
    return 'Pending';
  }
  if (status == InvoiceApprovalStatus.REJECT.name) {
    return 'Rejected';
  }
  if (status == InvoiceApprovalStatus.ACCEPT.name) {
    return 'Paid';
  }

  return 'Pending';
}
