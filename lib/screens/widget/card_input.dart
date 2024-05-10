import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:untitled1/utils/size_utils.dart';

class CardInputMyTextField extends StatelessWidget {
  const CardInputMyTextField({
    super.key,
    required this.maskTextInputFormatter,
    required this.controller,
    required this.onChanged,
  });

  final MaskTextInputFormatter maskTextInputFormatter;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.we),
      child: TextFormField(
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        inputFormatters: [maskTextInputFormatter],
        decoration: InputDecoration(
          hintText: "Card numbers...",
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10.we, vertical: 15.he),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.black, width: 2.we),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.black, width: 1.we),
          ),
        ),
      ),
    );
  }
}
