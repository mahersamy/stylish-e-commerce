import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    required this.height,
    required this.width,
    this.color,
  });

  final Widget widget;
  final VoidCallback onPressed;
  final int height;
  final int width;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(

        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStateProperty.all(color)),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
