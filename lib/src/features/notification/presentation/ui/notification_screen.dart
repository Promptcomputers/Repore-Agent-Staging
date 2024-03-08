import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:repore_agent/lib.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(getNofificationProvider);

    ref.listen<AsyncValue>(markNotificationAsRedProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getNofificationProvider);
      }
      if (value.hasError) {}
    });
    ref.listen<AsyncValue>(markAllNotificationProvider, (T, value) {
      if (value.hasValue) {
        ref.invalidate(getNofificationProvider);

        context.loaderOverlay.hide();
      }
      if (value.hasError) {
        context.loaderOverlay.hide();
        ref.invalidate(getNofificationProvider);
      }
    });

    return LoadingSpinner(
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(getNofificationProvider);
        },
        child: Scaffold(
          backgroundColor: AppColors.primarybgColor,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Row(
                  children: [
                    Image.asset(AppImages.checkMark),
                    XBox(5),
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(markAllNotificationProvider.notifier)
                            .markAllNotificationAsRead();
                        context.loaderOverlay.show();
                      },
                      child: Text(
                        'Mark all as read',
                        style: AppTextStyle.satoshiFontText(
                          context,
                          AppColors.buttonBgColor,
                          14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            title: Text(
              'Notifications',
              style: AppTextStyle.josefinSansFont(
                context,
                AppColors.homeContainerBorderColor,
                20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: AppColors.primaryColor, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.light, //<-- For Android SEE HERE (dark icons)
              statusBarBrightness:
                  Brightness.dark, //<-- For iOS SEE HERE (dark icons)
            ),
          ),
          body: SafeArea(
            ///Removed singlechild scroll view, because the empty state was centralizing to the middle
            child: vm.when(
              data: (value) {
                return value.data.isEmpty
                    ? const Center(child: EmptyNotificationStateWidget())
                    : ListView.separated(
                        padding:
                            EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: value.data.length,
                        itemBuilder: (context, index) {
                          final item = value.data[index];

                          return NotificationListWidget(
                            // imgUrl: item.imgUrl,
                            title: item.title,
                            subtitle: item.description,
                            isRead: item.status,
                            onTap: () {
                              // 651c18d546e3f527b1efb1f3
                              if (item.status == false) {
                                ///Only mark notification read is it has not been read
                                ref
                                    .read(
                                        markNotificationAsRedProvider.notifier)
                                    .markNotificationAsRead(item.id);
                              }
                              // if (item.title == 'Invoice Rejected') {
                              //   context.pushNamed(
                              //     AppRoute.invoicePreviewScreen.name,
                              //     queryParams: {
                              //       'invoiceId': item.metadata!.invoice,
                              //       'invoiceRef': '',
                              //       'subject': item.metadata!.subject,
                              //     },
                              //   );
                              // }

                              ///Direct user to ticket screen
                              if (item.metadata!.ticket.isNotEmpty) {
                                context.pushNamed(
                                  AppRoute.viewTicketScreen.name,
                                  queryParams: {
                                    'id': item.metadata!.ticket,
                                    'ref': '',
                                    'title': item.metadata!.subject,
                                  },
                                );
                              }

                              ///Direct user to invoice preview screen
                              if (item.metadata!.invoice.isNotEmpty) {
                                context.pushNamed(
                                  AppRoute.invoicePreviewScreen.name,
                                  queryParams: {
                                    'invoiceId': item.metadata!.invoice,
                                    'invoiceRef': '',
                                    'subject': item.metadata!.subject,
                                  },
                                );
                              }
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return YBox(20.h);
                        },
                      );
              },
              error: (error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      // error.toString(),
                      'An Error occurred',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.buttonBgColor,
                        14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ref.invalidate(getNofificationProvider);
                      },
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
              ),
              // error: (error, stackTrace) => const SizedBox(),
              loading: () => const AppCircularLoading(),
            ),
          ),
        ),
      ),
    );
  }
}
