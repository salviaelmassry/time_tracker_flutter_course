import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';
import 'package:time_tracker_flutter_course/app/home/models/entry.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:flutter/material.dart';

class EntryListItemModel {
  EntryListItemModel({this.job, this.entry, this.format});

  Job job;
  Entry entry;
  Format format;

  String get dayOfWeek => format.dayOfWeek(entry.start);

  String get startDate => format.date(entry.start);

  TimeOfDay get startTime => TimeOfDay.fromDateTime(entry.start);

  TimeOfDay get endTime => TimeOfDay.fromDateTime(entry.end);

  String get durationFormatted => format.hours(entry.durationInHours);

  double get pay => job.ratePerHour * entry.durationInHours;

  String get payFormatted => format.currency(pay);
}
