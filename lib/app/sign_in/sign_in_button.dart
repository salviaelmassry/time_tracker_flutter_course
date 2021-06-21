import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInButton extends CustomRaisedButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0.ssp),
          ),
          color: color,
          borderRadius: 8.0,
          height: 40,
          onPressed: onPressed,
        );
}
