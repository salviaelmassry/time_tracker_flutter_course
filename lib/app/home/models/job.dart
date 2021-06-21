import 'dart:ui';

import 'package:flutter/foundation.dart';

class Job {
  Job({@required this.id, @required this.name, @required this.ratePerHour});
  final String name;
  final int ratePerHour;
  final String id;
  // new type of constructor
  // use the factory keyword when
  // implementing a constructor that doesn't always create a new instance of its class
  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    final String name = data['name'];
    if(name == null) return null;
    final int ratePerHour = data['ratePerHour'];
    return Job(
      id: documentId,
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  //it's an integer representation of an object
  @override
  // TODO: implement hashCode
  int get hashCode => hashValues(id, name, ratePerHour);

  @override
  bool operator ==(Object other) {
    //  check if 2 instances are the same
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Job otherJob = other;
    return id == otherJob.id &&
        name == otherJob.name &&
        ratePerHour == otherJob.ratePerHour;
  }

  @override
  String toString() => 'id: $id, name: $name, ratePerHour: $ratePerHour';
}
