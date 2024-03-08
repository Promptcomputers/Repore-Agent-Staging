String formatCurrency(String number, {String currencyPrefix = '\$'}) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  mathFunc(Match match) => '${match[1]},';

  String result = number.replaceAllMapped(reg, mathFunc);
  return "$currencyPrefix$result";
}
