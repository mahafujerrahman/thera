import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:thera_track_app/controller/profileController.dart';
import 'package:thera_track_app/utils/app_colors.dart';
import 'package:thera_track_app/utils/style.dart';
import 'package:thera_track_app/views/base/custom_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: AppStyles.fontSize16(
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Give Feedback',
                      style: AppStyles.fontSize20(
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'What do you think of the app?',
                      style: AppStyles.fontSize16(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Emoji Rating Section
                    EmojiFeedback(
                      initialRating: 2,
                      animDuration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn,
                      inactiveElementScale: 0.5,
                      onChanged: (value) {
                        // Adjust value to match emojiMap keys (1-5)
                        final selectedEmoji = profileController.emojiMap[value] ?? 'Unknown';
                        profileController.setSelectedEmoji(selectedEmoji);
                        print('Selected Emoji: $selectedEmoji (Rating: ${value})');
                      },
                      onChangeWaitForAnimation: true,
                    ),
                    SizedBox(height: 20.h),
                    // Text Field for Feedback
                    TextField(
                      controller: profileController.feedbackController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write your message here...',
                        hintStyle: AppStyles.fontSize14(
                          color: AppColors.greyColor,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.secondaryColor),
                        ),
                        contentPadding: EdgeInsets.all(10.w),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return CustomButton(
                        loading: profileController.loading.value,
                        onTap: () {
                          profileController.feedbackGiven();
                        },
                        text: 'Send',
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}