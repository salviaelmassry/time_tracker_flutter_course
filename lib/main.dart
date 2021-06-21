import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';
import 'package:time_tracker_flutter_course/app/landing_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(279, 565),
      allowFontScaling: true,
      builder: () => MultiProvider(
        providers: [
          // auth is a service
          Provider<AuthBase>(create: (context) => Auth()),
          Provider<Format>(create: (context) => Format())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Time tracker",
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: LandingPage(),
        ),
      ),
    );
  }
}

// doSomething(List values, Function func) {
//   for (var v in values) {
//     var r = func(v);
//     print("Input: $v Output: $r");
//   }
// }
//
// double_num(n) {
//   return 2*n;
// }
//
// main() {
//   doSomething([1, 2, 3], (n) => n*n);
//
//   doSomething([4, 5], double_num);
// }
