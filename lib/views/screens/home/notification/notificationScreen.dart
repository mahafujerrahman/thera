import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Add intl package for date formatting
import 'package:thera_track_app/controller/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController notificationController = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    notificationController.getNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        centerTitle: true,
      ),
      body: Obx(() {
        final notifications = notificationController.getNotificationModel;
        if (notifications.isEmpty) {
          return Center(
            child: Text(
              'No notification at this moment.',
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];

            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notification.messageBody ?? 'N/A',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
