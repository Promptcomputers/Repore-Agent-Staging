import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class OnGoingTicketView extends ConsumerWidget {
  final List<Datum>? data;
  const OnGoingTicketView({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return data!.isEmpty
        ? const Center(
            child: EmptyNotificationStateWidget(
              message: 'You don’t have a ticket yet',
            ),
          )

        ///TODO: Look for a better to refresh
        : RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(searchTicketProvider);
            },
            child: ListView.separated(
              padding: EdgeInsets.only(
                  top: 20.h, left: 20.w, right: 20.w, bottom: 30.h),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: data!.length,
              separatorBuilder: (context, index) => YBox(20.h),
              itemBuilder: (context, index) {
                final item = data![index];
                return TicketListBuild(
                  type: item.type == null ? '' : item.type!.name,
                  title: item.subject,
                  // title: item.subject,
                  subtitle: item.description,
                  status: item.status,
                  titleColor: textColor(item.status),
                  bgColor: ticketBgColor(item.status),
                  statusBgColor: statusBgColor(item.status),
                  statusTextColor: statusTextColor(item.status),
                  onTap: () => context.pushNamed(
                    AppRoute.viewTicketScreen.name,
                    queryParams: {
                      'id': item.id,
                      'ref': item.reference,
                      'title': item.subject,
                    },
                  ),
                );
              },
            ),
          );
  }
}
