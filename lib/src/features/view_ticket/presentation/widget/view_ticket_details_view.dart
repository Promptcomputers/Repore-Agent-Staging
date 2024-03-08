import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class ViewTicketDetailsView extends ConsumerStatefulWidget {
  final String id;
  const ViewTicketDetailsView({required this.id, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewTicketDetailsViewState();
}

class _ViewTicketDetailsViewState extends ConsumerState<ViewTicketDetailsView> {
  bool hideContent = false;
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(viewSingleTickets(widget.id));
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      decoration: const BoxDecoration(
        color: AppColors.primarybgColor,
      ),

      child: vm.when(
        error: (error, stackTrace) => Text(
          error.toString(),
          style: AppTextStyle.satoshiFontText(
            context,
            AppColors.notificationHeaderColor,
            14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        // error: (error, stackTrace) => const SizedBox(),
        loading: () => const AppCircularLoading(),
        data: (value) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .pushNamed(AppRoute.invoiceScreen.name, queryParams: {
                      'ticketId': value.data!.ticket.id,
                      'invoiceTitle': value.data!.ticket.subject,
                      'customerName': '${value.data!.ticket.customer.firstname}'
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 10.w, top: 10.h, bottom: 10.h, right: 10.w),
                    decoration: BoxDecoration(
                      color: AppColors.buttonBgColor.withOpacity(0.2),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.buttonBgColor,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppIcon.viewInvoice),
                            XBox(5),
                            Text(
                              'View Invoices',
                              style: AppTextStyle.satoshiFontText(
                                context,
                                AppColors.buttonBgColor,
                                14.sp,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.buttonBgColor,
                          radius: 10.r,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.whiteColor,
                            size: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                YBox(20),
                Container(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 30.h,
                    bottom: 30.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.homeContainerBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Details',
                            style: AppTextStyle.satoshiFontText(
                              context,
                              AppColors.notificationHeaderColor,
                              14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                hideContent = !hideContent;
                              });
                            },
                            child: Icon(
                              hideContent
                                  ? Icons.keyboard_arrow_down
                                  : Icons.keyboard_arrow_up,
                              color: AppColors.primaryTextColor2,
                            ),
                          ),
                        ],
                      ),
                      // Text(
                      //   'Description',
                      //   style: AppTextStyle.satoshiFontText(
                      //     context,
                      //     AppColors.notificationHeaderColor,
                      //     14.sp,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // YBox(10.h),
                      // Text(
                      //   value.data!.ticket.description,
                      //   style: AppTextStyle.satoshiFontText(
                      //     context,
                      //     AppColors.headerTextColor1,
                      //     12.sp,
                      //   ),
                      // ),
                      // const Divider(),
                      hideContent
                          ? const SizedBox()
                          : Column(
                              children: [
                                YBox(10),
                                TicketDetailsWidget(
                                  text1: 'Customer',
                                  text2:
                                      '${capitalizeFirstLetter(value.data!.ticket.customer.firstname)} ${capitalizeFirstLetter(value.data!.ticket.customer.lastname)}',
                                  // text2: value.data!.ticket.id,
                                ),
                                YBox(10),
                                TicketDetailsWidget(
                                  text1: 'Ticket ID',
                                  text2: value.data!.ticket.reference
                                      .substring(0, 11),
                                  // text2: value.data!.ticket.id,
                                ),
                                YBox(10),
                                TicketDetailsWidget(
                                  text1: 'Service Type',
                                  text2: value.data!.ticket.type.name,
                                ),
                                YBox(10.h),
                                const TicketDetailsWidget(
                                  text1: 'Status',
                                  text2: 'Pending',
                                  textColor: AppColors.warningTextColor,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                YBox(20.h),
                Visibility(
                  visible: value.data!.files.isNotEmpty,
                  child: TicketAttachmentWidget(
                    files: value.data!.files,
                  ),
                ),
                // value.data!.files.isEmpty
                //     ? const SizedBox()
                //     : TicketAttachmentWidget(
                //         files: value.data!.files,
                //       ),
                // YBox(value.data!.files.isEmpty ? 0 : 20.h),
                // YBox(20.h),
                // value.data!.ticket.agent == null
                //     ? const SizedBox()
                //     : TicketAgentWidget(
                //         firstName: capitalizeFirstLetter(
                //             value.data!.ticket.agent!.firstname),
                //         lastName: value.data!.ticket.agent!.lastname,
                //         role: value.data!.ticket.agent!.role,
                //       ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TicketAgentWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String role;
  const TicketAgentWidget({
    required this.firstName,
    required this.lastName,
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 30.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(
          width: 1.w,
          color: AppColors.homeContainerBorderColor,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Agent',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.notificationHeaderColor,
              14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.buttonBgColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    '${getStringFirstLetter(firstName.toUpperCase())}${getStringFirstLetter(lastName.toUpperCase())}',
                    style: AppTextStyle.satoshiFontText(
                      context,
                      AppColors.buttonBgColor,
                      12.sp,
                    ),
                  ),
                ),
              ),
              XBox(10),
              Text(
                '$firstName $lastName',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.notificationHeaderColor,
                  14.sp,
                ),
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       '$firstName $lastName',
              //       style: AppTextStyle.bodyText(
              //         context,
              //         AppColors.notificationHeaderColor,
              //         14.sp,
              //       ),
              //     ),
              //     Text(
              //       '',
              //       // role,
              //       style: AppTextStyle.bodyText(
              //         context,
              //         AppColors.headerTextColor1,
              //         12.sp,
              //       ),
              //     ),
              //   ],
              // )
            ],
          )
        ],
      ),
    );
  }
}

class TicketAttachmentWidget extends StatefulWidget {
  // final String imgUrl;
  final List<FileElement> files;
  TicketAttachmentWidget({
    // required this.imgUrl,
    required this.files,
    Key? key,
  }) : super(key: key);

  @override
  State<TicketAttachmentWidget> createState() => _TicketAttachmentWidgetState();
}

class _TicketAttachmentWidgetState extends State<TicketAttachmentWidget> {
  bool hideContent = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 30.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(
          width: 1.w,
          color: AppColors.homeContainerBorderColor,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attachments',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.notificationHeaderColor,
                  14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    hideContent = !hideContent;
                  });
                  log('hideContent $hideContent');
                },
                child: Icon(
                  hideContent
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  color: AppColors.primaryTextColor2,
                ),
              ),
            ],
          ),
          YBox(10),
          hideContent
              ? const SizedBox()
              : GridView.builder(
                  // padding: EdgeInsets.only(
                  //     top: 55.h, left: 20.w, right: 20.w, bottom: 15.h),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.files.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 15.h,
                    mainAxisExtent: 70.h,
                  ),
                  itemBuilder: (context, index) {
                    final file = widget.files[index];
                    return Container(
                      width: 64.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                              width: 1.w, color: AppColors.primaryColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          width: 64.w,
                          height: 64.h,
                          fit: BoxFit.cover,
                          imageUrl:
                              "https://storage-promptcomputers.s3.us-east-2.amazonaws.com/${file.name}",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  })
        ],
      ),
    );
  }
}

class TicketDetailsWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final Color? textColor;
  const TicketDetailsWidget({
    required this.text1,
    required this.text2,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: AppTextStyle.satoshiFontText(
            context,
            AppColors.headerTextColor1,
            12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          text2,
          style: AppTextStyle.satoshiFontText(
            context,
            textColor ?? AppColors.headerTextColor2,
            12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
