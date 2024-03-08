num subTotal(List<dynamic> items, String invoiceType) {
  return items.fold(0, (num total, item) {
    num itemTotal = invoiceType == "SERVICE"
        ? item.hourly * item.totalHour
        : item.price * item.quantity;
    return total + itemTotal;
  });
}

num tax(num subTotal) {
  return (0.1 * subTotal).toInt();
}

num serviceCharge(num subTotal) {
  return (0.5 * subTotal).toInt();
}

num total(num subTotal, num tax, num serviceCharge) {
  return subTotal + tax + serviceCharge;
}
