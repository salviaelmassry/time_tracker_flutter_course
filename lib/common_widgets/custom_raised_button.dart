import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.height: 45,
    this.borderRadius: 2.0,
    this.onPressed,
  }) : assert(borderRadius != null && height != null);
  final Widget child;
  final Color color;
  //already flexible
  final double height;
  //already flexible
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: RaisedButton(
        child: child,
        color: color,
        disabledColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius.w),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
