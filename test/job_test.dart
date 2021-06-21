import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
    test('job with all properties', () {
      final job = Job.fromMap({
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
      // expect(job.name, 'Blogging');
      // expect(job.ratePerHour, 10);
      // expect(job.id, 'abc');
      expect(job, Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });
    test('missing name', () {
      final job = Job.fromMap({
        'ratePerHour': 10,
      }, 'abc');
      expect(job, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      final job = Job(name: 'Blogging', ratePerHour: 10);
      expect(job.toMap(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });
}
