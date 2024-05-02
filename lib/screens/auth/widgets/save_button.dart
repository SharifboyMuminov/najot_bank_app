import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/utils/app_colors.dart';

class SaveButton extends StatelessWidget {
  const SaveButton(
      {super.key,
      required this.onTab,
      required this.loading,
      required this.active});

  final VoidCallback onTab;
  final bool loading;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: active ? Colors.blue : Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        onPressed: active ? onTab : null,
        child: Center(
          child: loading
              ? const CircularProgressIndicator.adaptive()
              : Text(
                  "Ok",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
