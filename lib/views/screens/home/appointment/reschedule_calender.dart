import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:thera_track_app/controller/clientController/appointmentController.dart';
import 'package:thera_track_app/controller/clientController/service_controller.dart';
import 'package:thera_track_app/helpers/time_formate.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/app_icons.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/base/custom_list_tile.dart';

class AppoinmentRescheduleCalenderScreen extends StatefulWidget {
  const AppoinmentRescheduleCalenderScreen({super.key});

  @override
  _AppoinmentRescheduleCalenderScreenState createState() => _AppoinmentRescheduleCalenderScreenState();
}
class _AppoinmentRescheduleCalenderScreenState extends State<AppoinmentRescheduleCalenderScreen> {
  AppointmentController appointmentController =Get.put(AppointmentController());
  String? serviceID ='';
  var parameter = Get.parameters;

  DateTime selectedStartDate = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();

  // List of reminders
  List<String> reminderOptions = [
    "12 hour before",
    "1 Day before",
    "2 Day before",
    "1 week before",
  ];

  // Map to track selected reminder options
  Map<String, bool> selectedReminders = {};


  bool isAllDay = false;
  TimeOfDay selectedStartTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 12, minute: 0);

  DateTime selectedEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    serviceID = parameter['serviceID'];
    print('================>> ServiceID id ${serviceID}');
    for (var option in reminderOptions) {
      selectedReminders[option] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Reschedule',
          style: TextStyle(fontSize: 16.sp),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar Widget
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  // You can adjust this color as needed
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2024, 10, 20),
                  lastDay: DateTime.utc(2030, 10, 20),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(appointmentController.selectedAppointmentDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      appointmentController.selectedAppointmentDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: AppColors.cardColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColors.blackColor)),
                    selectedTextStyle: TextStyle(color: AppColors.blackColor),
                    todayDecoration: BoxDecoration(
                      color: AppColors.blackColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextFormatter:
                        (date, locale) => DateFormat.yMMMM(locale).format(date),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.colorE9F5FE,
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // All-Day Checkbox
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All-Day",
                                style: TextStyle(fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Checkbox(
                                value: isAllDay,
                                onChanged: (value) {
                                  setState(() {
                                    isAllDay = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.blue, thickness: 1),
                        // Start Time
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w,
                              vertical: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "Start",
                                  style: TextStyle(fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                    onTap: () async {
                                      final DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: selectedStartDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null &&
                                          pickedDate != selectedStartDate) {
                                        setState(() {
                                          selectedStartDate = pickedDate;
                                        });
                                      }
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(TimeFormatHelper.formatDate(appointmentController.selectedAppointmentDay ?? DateTime.now()),
                                          ),
                                        ))
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () async {
                                  final TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: selectedStartTime,
                                  );
                                  if (pickedTime != null && pickedTime != selectedStartTime) {
                                    setState(() {
                                      selectedStartTime = pickedTime;
                                      appointmentController.apStartTime.value = pickedTime.format(context);
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.r),
                                    child: Obx(() {
                                      return Text(appointmentController.apStartTime.value.isNotEmpty
                                          ? appointmentController.apStartTime.value
                                          : selectedStartTime.format(context));
                                    }),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),


                        // Conditionally render "End" section based on "All-Day" checkbox value
                        if (isAllDay)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8,
                                vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "End",
                                    style: TextStyle(fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryColor,
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.all(8.r),
                                            child: Text(TimeFormatHelper.formatDate(appointmentController.selectedAppointmentDay ?? DateTime.now()))
                                        )
                                    )
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () async {
                                    final TimeOfDay? pickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: selectedEndTime,
                                    );
                                    if (pickedTime != null && pickedTime != selectedEndTime) {
                                      setState(() {
                                        selectedEndTime = pickedTime;
                                        appointmentController.apEndTime.value = pickedTime.format(context);
                                      });
                                    }
                                  },
                                  child:    Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.r),
                                        child: Obx(() {
                                          return Text(appointmentController.apEndTime.value.isNotEmpty
                                              ? appointmentController.apEndTime.value
                                              : selectedStartTime.format(context));
                                        }),
                                      )),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Toggle the visibility of reminder options
                    appointmentController.isReminderAllDay.value = !appointmentController.isReminderAllDay.value;
                  });
                },
                child: CustomListTile(

                  title: 'Remainder',
                  suffixIcon: SvgPicture.asset(AppIcons.bottomArrow),
                ),
              ),


              if (appointmentController.isReminderAllDay.value)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    children: [
                      Obx(() {
                        return CheckboxListTile(
                          title: Text("12 hour before"),
                          value: appointmentController.reTwelveHourBefore.value,
                          onChanged: (bool? value) {
                            appointmentController.reTwelveHourBefore.value = value!;
                            print('12 hour before is ${appointmentController.reTwelveHourBefore.value}');
                          },
                        );
                      }),
                      // "1 Day before" Reminder Checkbox
                      Obx(() {
                        return CheckboxListTile(
                          title: Text("1 Day before"),
                          value: appointmentController.reOneDayBefore.value,
                          onChanged: (bool? value) {
                            appointmentController.reOneDayBefore.value = value!;
                            print('1 Day before is ${appointmentController.reOneDayBefore.value}');
                          },
                        );
                      }),

                      // "2 Day before" Reminder Checkbox
                      Obx(() {
                        return CheckboxListTile(
                          title: Text("2 Day before"),
                          value: appointmentController.reTwoDayBefore.value,
                          onChanged: (bool? value) {
                            appointmentController.reTwoDayBefore.value = value!;
                            print('2 Day before is ${appointmentController.reTwoDayBefore.value}');
                          },
                        );
                      }),

                      // "1 Week before" Reminder Checkbox
                      Obx(() {
                        return CheckboxListTile(
                          title: Text("1 week before"),
                          value: appointmentController.reOneWeekBefore.value,
                          onChanged: (bool? value) {
                            appointmentController.reOneWeekBefore.value = value!;
                            // Print the value when changed
                            print('1 week before is ${appointmentController.reOneWeekBefore.value}');
                          },
                        );
                      }),
                    ],
                  ),
                ),
              SizedBox(height: 16.h),
              // Done Button
              CustomButton(onTap: () {
                appointmentController.appointmentReschedule(
                    serviceID: serviceID!
                );
              }, text: 'Save'),
            ],
          ),
        ),
      ),
    );
  }
}