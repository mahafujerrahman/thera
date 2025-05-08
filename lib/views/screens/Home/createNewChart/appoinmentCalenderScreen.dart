import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:thera_track_app/views/base/custom_button.dart';


class AppColors {
  static const Color cardColor = Colors.blue;
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
}

class AppoinmentCalenderScreen extends StatefulWidget {
  const AppoinmentCalenderScreen({super.key});

  @override
  _AppoinmentCalenderScreenState createState() => _AppoinmentCalenderScreenState();
}

class _AppoinmentCalenderScreenState extends State<AppoinmentCalenderScreen> {

  DateTime selectedStartDate = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  // List of reminders
  List<String> reminderOptions = [
    "12 hour before",
    "1 Day before",
    "2 Day before",
    "1 week before",
  ];

  // Map to track selected reminder options
  Map<String, bool> selectedReminders = {};

  @override
  void initState() {
    super.initState();

    for (var option in reminderOptions) {
      selectedReminders[option] = false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment Calendar',
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
                  color: Colors.blue.shade50, // You can adjust this color as needed
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child:  TableCalendar(
                  firstDay: DateTime.utc(2024, 10, 20),
                  lastDay: DateTime.utc(2030, 10, 20),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
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

              // Display
              Text(
                'Selected Date: $_selectedDay}.',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16.h),

              // Reminder Checkboxes
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: reminderOptions.map((option) {
                    return CheckboxListTile(
                      title: Text(option),
                      value: selectedReminders[option],
                      onChanged: (bool? value) {
                        setState(() {
                          selectedReminders[option] = value!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.h),
              CustomButton(onTap: (){}, text: 'Done')
            ],
          ),
        ),
      ),
    );
  }
}
