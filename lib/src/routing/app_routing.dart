import 'package:go_router/go_router.dart';
import 'package:repore_agent/lib.dart';

enum AppRoute {
  auth,
  login,
  splash,
  autoLogin,

  forgotPassword,
  changePassword,
  bottomNavBar,
  otpScreen,
  viewTicketScreen,
  invoiceScreen,
  createInvoiceScreen,
  createInvoicePreviewScreen,
  invoicePreviewScreen,
  invoicePaymentScreen,
  invoiceCreatedSuccessScreen,
  editProfileScreen,
  changePasswordScreen,

  bankDetailsScreen,
  addBankDetailsScreen,
  createPinScreen,
  confirmCreatePinScreen,
  withdrawal,
  completeProfileScreen,
  viewSingleTransactionScreen,
  withdrawalPendingScreen,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: 'auth',
          name: AppRoute.auth.name,
          builder: (context, state) {
            return const AuthHomePage();
            // return MainScreen(menuScreenContext: context);
          },
        ),
        GoRoute(
          path: 'bottomNavBar',
          name: AppRoute.bottomNavBar.name,
          builder: (context, state) {
            return const BottomNavBar();
            // return MainScreen(menuScreenContext: context);
          },
        ),
        GoRoute(
          path: 'login',
          name: AppRoute.login.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
            path: 'autoLogin',
            name: AppRoute.autoLogin.name,
            builder: (context, state) {
              final email = state.queryParams['email']!;
              final firstName = state.queryParams['firstName']!;
              return AutoLoginScreen(email: email, firstName: firstName);
            }),
        GoRoute(
          path: 'forgotPassword',
          name: AppRoute.forgotPassword.name,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: 'changePassword/:id',
          name: AppRoute.changePassword.name,
          builder: (context, state) {
            final id = state.params['id']!;
            return ChangeForgotPasswordScreen(id: id);
          },
        ),
        GoRoute(
          path: 'otpScreen',
          name: AppRoute.otpScreen.name,
          builder: (context, state) {
            final email = state.queryParams['email']!;
            final id = state.queryParams['id']!;
            return OtpScreen(email: email, id: id);
          },
        ),
        GoRoute(
          path: 'changePasswordScreen',
          name: AppRoute.changePasswordScreen.name,
          builder: (context, state) {
            return const ChangePasswordScreen();
          },
        ),
        GoRoute(
          path: 'bankDetailsScreen',
          name: AppRoute.bankDetailsScreen.name,
          builder: (context, state) {
            return const BankDetailsScreen();
          },
        ),
        GoRoute(
          path: 'addBankDetailsScreen',
          name: AppRoute.addBankDetailsScreen.name,
          builder: (context, state) {
            return const AddBankDetailsScreen();
          },
        ),
        GoRoute(
          path: 'createPinScreen/:isFromComplete',
          name: AppRoute.createPinScreen.name,
          builder: (context, state) {
            ///1: true, 0:false
            final isFromComplete = state.params['isFromComplete']!;
            return CreatePinScreen(
              isFromComplete: isFromComplete,
            );
          },
        ),
        GoRoute(
          path: 'confirmCreatePinScreen/:pin',
          name: AppRoute.confirmCreatePinScreen.name,
          builder: (context, state) {
            final pin = state.params['pin']!;
            return ConfirmCreatePinScreen(
              pin: pin,
            );
          },
        ),
        GoRoute(
          path: 'viewTicketScreen',
          name: AppRoute.viewTicketScreen.name,
          builder: (context, state) {
            final id = state.queryParams['id']!;
            final ref = state.queryParams['ref']!;
            final title = state.queryParams['title']!;
            return ViewTicketScreen(
              id: id,
              ref: ref,
              title: title,
            );
          },
        ),
        GoRoute(
          path: 'invoiceScreen',
          name: AppRoute.invoiceScreen.name,
          builder: (context, state) {
            final ticketId = state.queryParams['ticketId']!;
            final invoiceTitle = state.queryParams['invoiceTitle']!;
            final customerName = state.queryParams['customerName']!;
            return InvoiceScreen(
              ticketId: ticketId,
              invoiceTitle: invoiceTitle,
              customerName: customerName,
            );
          },
        ),
        GoRoute(
          path: 'createInvoiceScreen',
          name: AppRoute.createInvoiceScreen.name,
          builder: (context, state) {
            final ticketId = state.queryParams['ticketId']!;
            final invoiceTitle = state.queryParams['invoiceTitle']!;
            final customerName = state.queryParams['customerName']!;
            final invoiceType = state.queryParams['invoiceType']!;
            return CreateInvoiceScreen(
                ticketId: ticketId,
                invoiceTitle: invoiceTitle,
                customerName: customerName,
                invoiceType: invoiceType);
          },
        ),
        GoRoute(
          path: 'invoicePreviewScreen',
          name: AppRoute.invoicePreviewScreen.name,
          builder: (context, state) {
            final invoiceId = state.queryParams['invoiceId']!;
            final invoiceRef = state.queryParams['invoiceRef']!;
            final subject = state.queryParams['subject']!;
            return InvoicePreviewScreen(
              invoiceId: invoiceId,
              invoiceRef: invoiceRef,
              subject: subject,
            );
          },
        ),
        GoRoute(
          path: 'createInvoicePreviewScreen',
          name: AppRoute.createInvoicePreviewScreen.name,
          builder: (context, state) {
            final ticketId = state.queryParams['ticketId']!;
            final invoiceTitle = state.queryParams['invoiceTitle']!;
            final customerName = state.queryParams['customerName']!;
            final dueDateController = state.queryParams['dueDateController']!;
            final note = state.queryParams['note']!;
            final invoiceType = state.queryParams['invoiceType']!;
            final invoiceDetails =
                state.queryParams['invoiceDetails']! as List<Field>;
            final serviceInvoiceDetails =
                state.queryParams['invoiceDetails']! as List<ServiceField>;
            return CreateInvoicePreviewScreen(
              ticketId: ticketId,
              invoiceTitle: invoiceTitle,
              customerName: customerName,
              dueDateController: dueDateController,
              note: note,
              invoiceDetails: invoiceDetails,
              invoiceType: invoiceType,
              serviceInvoiceDetails: serviceInvoiceDetails,
            );
          },
        ),
        GoRoute(
          path: 'invoiceCreatedSuccessScreen/:customerName',
          name: AppRoute.invoiceCreatedSuccessScreen.name,
          builder: (context, state) {
            final customerName = state.params['customerName']!;
            return InvoiceCreatedSuccessScreen(
              customerName: customerName,
            );
          },
        ),
        GoRoute(
          path: 'withdrawal',
          name: AppRoute.withdrawal.name,
          builder: (context, state) {
            return WithdrawalScreen();
          },
        ),
        GoRoute(
          path: 'completeProfileScreen',
          name: AppRoute.completeProfileScreen.name,
          builder: (context, state) {
            return const CompleteProfileScreen();
          },
        ),
        GoRoute(
          path: 'viewSingleTransactionScreen',
          name: AppRoute.viewSingleTransactionScreen.name,
          builder: (context, state) {
            return const ViewSingleTransactionScreen();
          },
        ),
        GoRoute(
          path: 'withdrawalPendingScreen',
          name: AppRoute.withdrawalPendingScreen.name,
          builder: (context, state) {
            return const WithdrawalPendingScreen();
          },
        ),
      ],
    ),
  ],
);
