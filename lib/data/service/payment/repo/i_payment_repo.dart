import 'package:repore_agent/lib.dart';

abstract class IPaymentServiceRepo {
  ///Get all invoice for a ticket
  Future<GetAllTransactionRes> getAllTransactions();

  ///Add Bank details
  Future<bool> addBank(String accountNumber, String routingNumber,
      String accountName, bool isDefault, String ssn);

  ///Get user saved bank details
  Future<GetBankDetailRes> getSavedBankDetails();

  ///Delete bank details
  Future<bool> deleteBankDetail(String bankId);

  ///Get user balance
  Future<WalletBalanceRes> getUserBalance();

  ///Withdrawal
  Future<bool> withdrawal(String amount, String bankAccount, String pin);

  ///Cashout
  Future<bool> cashout(String invoiceId);
}
