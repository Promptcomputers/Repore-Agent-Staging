import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

///Make both autodipsose incase user is current on the app, and a user pay them, so they can get new value
final getAllTransactionProvider =
    FutureProvider.autoDispose<GetAllTransactionRes>((ref) async {
  return await ref.watch(paymentServiceRepoProvider).getAllTransactions();
});

final getUserBalanceProvider =
    FutureProvider.autoDispose<WalletBalanceRes>((ref) async {
  return await ref.watch(paymentServiceRepoProvider).getUserBalance();
});
