import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/views/base/custom_button.dart';
import 'package:thera_track_app/views/screens/Home/createNewChart/timePicker.dart';

class AppoinmentCalenderScreen extends StatefulWidget {
  @override
  _AppoinmentCalenderScreenState createState() => _AppoinmentCalenderScreenState();
}

class _AppoinmentCalenderScreenState extends State<AppoinmentCalenderScreen> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 12, minute: 0);


  String selectedReminder = "Reminder";

  List<String> reminderOptions = [
    "Reminder",
    "10 minutes before",
    "30 minutes before",
    "1 hour before",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Calender',
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
                  color: AppColors.colorE9F5FE,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // All-Day Checkbox

              SizedBox(height: 16.h),

              // Start and End Time
              TimePickerWidget(),
              SizedBox(height: 16.h),

              // Reminder Dropdown
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.colorE9F5FE,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedReminder,
                    items: reminderOptions
                        .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option,
                          style: TextStyle(fontSize: 14.sp)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReminder = value!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Done Button
              CustomButton(onTap: () {}, text: 'Done'),
            ],
          ),
        ),
      ),
    );
  }


}
