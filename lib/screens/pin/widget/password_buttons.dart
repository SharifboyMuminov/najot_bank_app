import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordButtons extends StatelessWidget {
  const PasswordButtons({
    super.key,
    required this.onChange,
    required this.onTabClear,
    this.showTouchId = false,
    this.onTabTouchId,
  });

  final ValueChanged<String> onChange;
  final VoidCallback onTabClear;
  final bool showTouchId;
  final VoidCallback? onTabTouchId;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        children: [
          ...List.generate(
            9,
            (index) {
              return TextButton(
                onPressed: () {
                  onChange.call(index.toString());
                },
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 25.sp,
                  ),
                ),
              );
            },
          ),
          showTouchId
              ? TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.touch_app,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          TextButton(
            onPressed: () {
              onChange.call("0");
            },
            child: Text(
              "0",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25.sp,
              ),
            ),
          ),
          TextButton(
            onPressed: onTabClear,
            child: Icon(
              Icons.backspace_sharp,
              size: 24.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
