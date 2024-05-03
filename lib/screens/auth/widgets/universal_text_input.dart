import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/utils/app_colors.dart';
import 'package:untitled1/utils/size_utils.dart';

class UniversalTextInput extends StatelessWidget {
  const UniversalTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.type,
    required this.regExp,
    required this.onChange,
    required this.errorTitle,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final RegExp regExp;
  final String errorTitle;
  final ValueChanged<String> onChange;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: TextFormField(
        onChanged: onChange,
        style: Theme.of(context).textTheme.bodyMedium,
        controller: controller,
        keyboardType: type,
        validator: (String? value) {
          if (value == null ||
              value.isEmpty ||
              value.length < 3 ||
              !regExp.hasMatch(value)) {
            return "Enter true $errorTitle";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Theme.of(context).primaryColorLight,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.we, vertical: 20.he),
          labelText: hintText,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
