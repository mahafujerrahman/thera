import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thera_track_app/utils/app_colors.dart';

class TimePickerWidget extends StatefulWidget {
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 12, minute: 0);
  bool isAllDay = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Start",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
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
                          if (pickedDate != null && pickedDate != selectedStartDate) {
                            setState(() {
                              selectedStartDate = pickedDate;
                            });
                          }
                        },
                        child: _buildTimeContainer(
                          text: "${selectedStartDate.day} ${_getMonthName(selectedStartDate.month)}, ${selectedStartDate.year}",
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 100.w,
                      child: GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedStartTime,
                          );
                          if (pickedTime != null && pickedTime != selectedStartTime) {
                            setState(() {
                              selectedStartTime = pickedTime;
                            });
                          }
                        },
                        child: _buildTimeContainer(
                          text: selectedStartTime.format(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              // Conditionally render "End" section based on "All-Day" checkbox value
              if (isAllDay)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "End",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedEndDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null && pickedDate != selectedEndDate) {
                              setState(() {
                                selectedEndDate = pickedDate;
                              });
                            }
                          },
                          child: _buildTimeContainer(
                            text: "${selectedEndDate.day} ${_getMonthName(selectedEndDate.month)}, ${selectedEndDate.year}",
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 100.w,
                        child: GestureDetector(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedEndTime,
                            );
                            if (pickedTime != null && pickedTime != selectedEndTime) {
                              setState(() {
                                selectedEndTime = pickedTime;
                              });
                            }
                          },
                          child: _buildTimeContainer(
                            text: selectedEndTime.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeContainer({required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 14.sp),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }
}

