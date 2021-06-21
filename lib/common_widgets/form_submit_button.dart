import 'package:flutter/Material.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({@required String text, VoidCallback onPressed})
      : super(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20.ssp),
            ),
            height: 33,
            color: Colors.indigo,
            borderRadius: 4,
            onPressed: onPressed);
}
