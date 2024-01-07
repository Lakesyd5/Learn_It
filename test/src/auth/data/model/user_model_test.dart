import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/auth/data/model/user_model.dart';
import 'package:learn_it/src/auth/domain/entities/user_entity.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test(
    'should be a subclass of [localUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );

  final tMap = jsonDecode(fixture('user.json')) as DataMap;

  group('fromMap', () {
    test('should return a valid [LocalUserModel] from the map', () {
      // act
      final result = LocalUserModel.fromMap(tMap);

      expect(result, isA<LocalUserModel>());
      expect(result, equals(tLocalUserModel));
    });

    test('should throw an [error] when the map is invalid', () {
      final map = DataMap.from(tMap)..remove('uid');

      const call = LocalUserModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test(
      'should return a valid [DataMap] from map',
      () {
        final result = tLocalUserModel.toMap();

        expect(result, equals(tMap));
      },
    );
  });

  group('copyWith', () {
    test(
      'should a retrun a',
      () {
        final result = tLocalUserModel.copyWith(uid: '2');

        expect(result.uid, '2');
      },
    );
  });

}
