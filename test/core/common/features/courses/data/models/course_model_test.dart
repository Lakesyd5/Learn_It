import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/common/features/courses/data/models/course_model.dart';
import 'package:learn_it/core/common/features/courses/domain/entities/course.dart';
import 'package:learn_it/core/utils/typedefs.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final timeStampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };

  final date = DateTime.fromMicrosecondsSinceEpoch(timeStampData['_seconds']!)
      .add(Duration(microseconds: timeStampData['_nanoseconds']!));

  final timestamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel.empty();

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timestamp;
  tMap['updatedAt'] = timestamp;

  test(
    'should be a sub class of [Course] entity',
    () => expect(tCourseModel, isA<Course>()),
  );

  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = CourseModel.empty();

      expect(result.title, '_empty.title');
    });
  });

  group(
    'fromMap',
    () {
      test('should return a valid [CourseModel] from the map', () {
        final result = CourseModel.fromMap(tMap);

        expect(result, isA<CourseModel>());
        expect(result, equals(tCourseModel));
      });
    },
  );

  group(
    'toMap',
    () {
      test('should return a valid [CourseModel] to the Map', () {
        final result = tCourseModel.toMap()
          ..remove('createdAt')
          ..remove('updatedAt');

        final map = DataMap.from(tMap)
          ..remove('createdAt')
          ..remove('updatedAt');
        expect(result, equals(map));
      });
    },
  );

  group('copyWith', () {
    test('should return a [CourseModel] with the new Data', () {
      final result = tCourseModel.copyWith(title: 'New Title');

      expect(result.title, equals('New Title'));
    });
  });
}
