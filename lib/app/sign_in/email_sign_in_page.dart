import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_change_notifier.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Sign In"),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Card(child: EmailSignInFormChangeNotifier.create(context)
                // child: EmailSignInFormStateful(
                // onSignedIn: () => Navigator.pop(context),
                ),
          ),
        ));
  }
}
