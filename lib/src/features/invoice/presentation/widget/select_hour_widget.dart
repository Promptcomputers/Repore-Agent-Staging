import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repore_agent/lib.dart';

class SelectHourAlertDialogWidget extends StatefulWidget {
  final TextEditingController hourController;
  final TextEditingController totalDuration;
  SelectHourAlertDialogWidget(
      {required this.hourController, required this.totalDuration, super.key});

  @override
  State<SelectHourAlertDialogWidget> createState() =>
      _SelectHourAlertDialogWidgetState();
}

class _SelectHourAlertDialogWidgetState
    extends State<SelectHourAlertDialogWidget> {
  final minController = TextEditingController();
  final selectedHourController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: AlertDialog(
            backgroundColor: AppColors.whiteColor,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Hour',
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.headerTextColor1,
                        16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    YBox(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                              text: 'Hours',
                            ),
                            YBox(6),
                            SizedBox(
                              width: 120.w,
                              child: AppTextField(
                                hintText: 'Enter hours',
                                controller: selectedHourController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                              text: 'Minutes',
                            ),
                            YBox(6),
                            SizedBox(
                              width: 120.w,
                              child: AppTextField(
                                hintText: 'Select Minutes',
                                readOnly: true,
                                controller: minController,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return MinuteSliderWidget(
                                        minController: minController,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    YBox(30),
                    AppButton(
                      buttonText: 'Done',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          int selectedHour =
                              int.tryParse(selectedHourController.text) ?? 0;
                          int selectedMin =
                              int.tryParse(minController.text) ?? 0;
                          widget.hourController.text =
                              '${selectedHourController.text}:${minController.text}';
                          widget.totalDuration.text =
                              ((selectedHour * 60) + selectedMin).toString();
                          Console.print('duration ${widget.totalDuration}');
                          context.pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MinuteSliderWidget extends StatefulWidget {
  final TextEditingController minController;
  const MinuteSliderWidget({super.key, required this.minController});

  @override
  State<MinuteSliderWidget> createState() => _MinuteSliderWidgetState();
}

class _MinuteSliderWidgetState extends State<MinuteSliderWidget> {
  int _selectedMinutes = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //TODO: Display the minute selected before when user reclick after selecting
            Text(
              'Selected minute: $_selectedMinutes minute${_selectedMinutes > 1 ? 's' : ''}',
              style: TextStyle(fontSize: 20.0),
            ),
            Slider(
              value: _selectedMinutes.toDouble(),
              activeColor: AppColors.primaryColor2,
              thumbColor: AppColors.primaryColor2,
              min: 0,
              max: 60,
              divisions: 60,
              onChanged: (newValue) {
                setState(() {
                  _selectedMinutes = newValue.toInt();
                  widget.minController.text = _selectedMinutes.toString();
                });
              },
            ),
            YBox(_selectedMinutes <= 0 ? 0 : 5),
            _selectedMinutes <= 0
                ? SizedBox()
                : AppButton(
                    buttonText: 'Done',
                    onPressed: () {
                      context.pop();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
