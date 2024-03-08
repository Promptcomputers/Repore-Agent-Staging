import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final getUserBankDetails =
    FutureProvider.autoDispose<GetBankDetailRes>((ref) async {
  return await ref.watch(paymentServiceRepoProvider).getSavedBankDetails();
});

final addBankDetailsProvider =
    StateNotifierProvider<AddBankDetailVM, AsyncValue<bool>>((ref) {
  return AddBankDetailVM(ref);
});

class AddBankDetailVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  AddBankDetailVM(this.ref) : super(AsyncData(true));

  void addBankDetail(String accountNumber, String routingNumber,
      String accountName, bool isDefault, String ssn) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(paymentServiceRepoProvider)
          .addBank(accountNumber, routingNumber, accountName, isDefault, ssn));
    } catch (e, s) {
      log('error from AddBankDetailvm $e');
      state = AsyncValue.error(e, s);
    }
  }
}

final withdrawalProvider =
    StateNotifierProvider<WithdrawalVM, AsyncValue<bool>>((ref) {
  return WithdrawalVM(ref);
});

class WithdrawalVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  WithdrawalVM(this.ref) : super(AsyncData(true));

  void withdraw(String amount, String bankAccount, String pin) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(paymentServiceRepoProvider)
          .withdrawal(amount, bankAccount, pin));
    } catch (e, s) {
      log('error from withdrawlVM $e');
      state = AsyncValue.error(e, s);
    }
  }
}

final deleteBankDetailProvider =
    StateNotifierProvider<DeleteBankDetailVM, AsyncValue<bool>>((ref) {
  return DeleteBankDetailVM(ref);
});

class DeleteBankDetailVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  DeleteBankDetailVM(this.ref) : super(AsyncData(true));

  void deleteBankDetail(String bankId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(paymentServiceRepoProvider).deleteBankDetail(bankId));
    } catch (e, s) {
      log('error from deleteBank VM $e');
      state = AsyncValue.error(e, s);
    }
  }
}

final createStripeTokenProvider =
    StateNotifierProvider<CreateStripeTokenVM, AsyncValue<dynamic>>((ref) {
  return CreateStripeTokenVM(ref);
});

class CreateStripeTokenVM extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  CreateStripeTokenVM(this.ref) : super(AsyncData(false));

  Future<String> createStripeToken(String accountNumber, String country,
      String currency, String routingNumber) async {
    try {
      final token = await Stripe.instance.createToken(
        CreateTokenParams.bankAccount(
          params: BankAccountTokenParams(
            type: TokenType.BankAccount,
            accountNumber: accountNumber,
            country: country,
            currency: currency,
            routingNumber: routingNumber,
            accountHolderName: 'Obaro Dayo Michael',
          ),
        ),
      );
      log('token $token');

      return token.id;
    } catch (error) {
      log('An error occured creating stripe token $error');
      rethrow;
    }
  }

  Future<dynamic> collectBankAccount() async {
    final stripeInstance = Stripe.instance;
    try {
      final b = await stripeInstance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(),
      );
      // final a = await stripeInstance.presentPaymentSheet();

      // final collectBank = await Stripe.instance.collectBankAccount(
      //   isPaymentIntent: true,
      //   clientSecret:
      //       'seti_1OFiKhH3aI1kPWD1OzfNgzV0_secret_P3q0QKNPGJ6htnwK4hnYhCEl69RNaAs',
      //   params: CollectBankAccountParams(
      //     billingDetails: BillingDetails(
      //       name: 'dayo obaro',
      //       phone: '2347016181313',
      //       email: 'dayoobaro@promptcomputers.io',
      //       address: Address(
      //         city: 'Houston',
      //         country: 'US',
      //         line1: '1459  Circle Drive',
      //         line2: '14591  Circle Drive',
      //         state: 'Texas',
      //         postalCode: '77063',
      //       ),
      //     ),
      //     paymentMethodType: PaymentMethodType.USBankAccount,
      //   ),
      // );
      // log('collectBank $collectBank');
      // // log('token $token');
      log('a $b');
      // return collectBank;
      // return token.id;
      return b;
    } catch (error) {
      log('An error occured while collecting bank account $error');
      rethrow;
    }
  }
}
