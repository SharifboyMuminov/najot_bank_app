import 'package:banking_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversalTextInput extends StatelessWidget {
  const UniversalTextInput(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.type,
      required this.regExp,
      required this.errorTitle,
      required this.iconPath});

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final RegExp regExp;
  final String errorTitle;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.transparent,
      child: TextFormField(
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
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(iconPath),
          ),
          contentPadding: const EdgeInsets.all(16),
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
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
