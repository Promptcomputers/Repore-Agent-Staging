import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final paymentServiceRepoProvider = Provider<PaymentServiceRepo>((ref) {
  final paymentService = ref.watch(paymentServiceProvider);
  return PaymentServiceRepo(paymentService);
});

class PaymentServiceRepo extends IPaymentServiceRepo {
  final PaymentService _paymentService;
  PaymentServiceRepo(this._paymentService);

  @override
  Future<GetAllTransactionRes> getAllTransactions() async {
    return await _paymentService.getAllTransactions();
  }

  @override
  Future<bool> addBank(String accountNumber, String routingNumber,
      String accountName, bool isDefault, String ssn) async {
    return await _paymentService.addBank(
        accountNumber, routingNumber, accountName, isDefault, ssn);
  }

  @override
  Future<bool> deleteBankDetail(String bankId) async {
    return await _paymentService.deleteBankDetail(bankId);
  }

  @override
  Future<GetBankDetailRes> getSavedBankDetails() async {
    return await _paymentService.getSavedBankDetails();
  }

  @override
  Future<WalletBalanceRes> getUserBalance() async {
    return await _paymentService.getUserBalance();
  }

  @override
  Future<bool> withdrawal(String amount, String bankAccount, String pin) async {
    return await _paymentService.withdrawal(amount, bankAccount, pin);
  }

  @override
  Future<bool> cashout(String invoiceId) async {
    return await _paymentService.cashout(invoiceId);
  }
}
