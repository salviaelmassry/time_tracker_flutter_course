import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/common_widgets/custom_raised_button.dart';

void main() {
  testWidgets('onPressed callback', (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidget(ScreenUtilInit(
        designSize: Size(279, 565),
        allowFontScaling: true,
        builder: () => MaterialApp(
              home: CustomRaisedButton(
                child: Text('tap me'),
                onPressed: () => pressed = true,
              ),
            )));
    // finders and matchers can be used to find widgets
    final button = find.byType(RaisedButton);
    expect(button, findsOneWidget);
    expect(find.byType(FlatButton), findsNothing);
    expect(find.text('tap me'), findsOneWidget);
    // we can also test the interaction with our widgets
    // always use await when calling tester methods
    await tester.tap(button);
    expect(pressed, true);

  });
}
