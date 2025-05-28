import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.color,
        this.textColor,
        this.textStyle,
        this.padding = EdgeInsets.zero,
        required this.onTap,
        required this.text,
        this.loading = false,
        this.width,
        this.height,
        this.prefixIcon});

  final Function() onTap;
  final String text;
  final bool loading;
  final double? height;
  final double? width;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: loading ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.w, color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(4.r),
          ),
          backgroundColor: color ?? AppColors.primaryColor,
          minimumSize: Size(width ?? Get.width, height ?? 53.h),
        ),
        child: loading ? SizedBox(child: CircularProgressIndicator(color: Colors.white),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon!.icon, color: color ?? AppColors.whiteColor),
              SizedBox(width: 4.w),
            ],
            Text(text, style: textStyle ?? AppStyles.fontSize18(fontWeight: FontWeight.w400, color: textColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
