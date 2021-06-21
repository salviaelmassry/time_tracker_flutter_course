import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  final format = Format();
  group('hours', () {
    test('positive', () {
      expect(format.hours(10), '10h');
    });
    test('zero', () {
      expect(format.hours(0), '0h');
    });
    test('negative', () {
      expect(format.hours(-5), '0h');
    });
    test('decimal', () {
      expect(format.hours(4.5), '4.5h');
    });
  });
  group('date - GB Locale', () {
    ///////////--------------////////////
    ///runs before each test
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    ///////////---------------/////////////
    test('2019-08-12', () {
      expect(format.date(DateTime(2019, 8, 12)), '12 Aug 2019');
    });
    test('2019-08-16', () {
      expect(format.date(DateTime(2019, 8, 16)), '16 Aug 2019');
    });
  });
  group('dayOfWeek - GB locale', () {
    ///////////--------------////////////
    ///runs before each test
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    ///////////---------------/////////////
    test('Monday', () {
      expect(format.dayOfWeek(DateTime(2019, 8, 12)), 'Mon');
    });
  });
  group('dayOfWeek - IT locale', () {
    ///////////--------------////////////
    ///runs before each test
    setUp(() async {
      Intl.defaultLocale = 'it_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    ///////////---------------/////////////
    test('Lunedi', () {
      expect(format.dayOfWeek(DateTime(2019, 8, 12)), 'lun');
    });
  });
  group('currency - US locale', () {
    ///////////--------------////////////
    ///runs before each test
    setUp(() => Intl.defaultLocale = 'en_US');
    ///////////---------------/////////////
    test('positive', () {
      expect(format.currency(10), '\$10');
    });
    test('zero', () {
      expect(format.currency(0), '');
    });
    test('negative', () {
      expect(format.currency(-5), '-\$5');
    });
  });
}
