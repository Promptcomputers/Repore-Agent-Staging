import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    ref.read(authControllerProvider.notifier).getAuth();
    // Future.wait([getUrl()]).then((value) {
    //   Future.delayed(const Duration(milliseconds: 5000), () async {
    //     context.pushReplacementNamed(
    //       AppRoute.auth.name,
    //     );
    //   });
    // });

    Future.delayed(const Duration(milliseconds: 5000), () async {
      context.pushReplacementNamed(
        AppRoute.auth.name,
      );
    });
    super.initState();
  }

  // Future<String> getUrl() async {
  //   AppConfig.coreBaseUrl = await DatabaseService().baseUrl().catchError((e) {
  //     log('error while fetching url $e');
  //     return 'https://prod.api.repore.promptcomputers.io/api/v1/agent/';
  //   });

  //   return AppConfig.coreBaseUrl;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image(
                image: const AssetImage(AppImages.logo2),
                width: 200.w,
                // height: 250.h,
              ),
            ),
            YBox(10.h),
            Text(
              'Welcome to the neighborhood',
              style: AppTextStyle.josefinSansFont(
                context,
                AppColors.whiteColor,
                16.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
