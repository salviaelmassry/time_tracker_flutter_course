import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    @required String assetName,
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null && assetName!= null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetName),
              Text(
                text,
                style: TextStyle(color: textColor, fontSize: 15.0.ssp),
              ),
              Opacity(opacity: 0, child: Image.asset(assetName)),
            ],
          ),
          color: color,
          borderRadius: 8.0,
          height: 40,
          onPressed: onPressed,
        );
}
