import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent(
      {Key key,
      this.title = 'Nothing here',
      this.message = 'Add a new item to get started'})
      : super(key: key);
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 32.ssp, color: Colors.black54),
          ),
          Text(
            message,
            style: TextStyle(fontSize: 16.ssp, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
