import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:learn_it/core/common/features/courses/data/datasources/course_remote_data_source.dart';
import 'package:learn_it/core/common/features/courses/data/models/course_model.dart';

void main() {
  late CourseRemoteDataSource remoteDataSource;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth auth;
  late MockFirebaseStorage storage;

  setUp(() async {
    firestore = FakeFirebaseFirestore();

    final user = MockUser();

    final googleSignIn = MockGoogleSignIn();
    final signInAccount = await googleSignIn.signIn();
    final googleAuth = await signInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    auth = MockFirebaseAuth(mockUser: user);
    await auth.signInWithCredential(credential);

    storage = MockFirebaseStorage();

    remoteDataSource = CourseRemoteDataSourceImpl(
      firestore: firestore,
      storage: storage,
      auth: auth,
    );
  });

  group('addCourse', () {
    test('should add the given course to the firestore collection', () async {
      // Arrange
      final course = CourseModel.empty();

      // Act
      await remoteDataSource.addCourse(course);

      // Assert
      final firestoreData = await firestore.collection('courses').get();
      expect(firestoreData.docs.length, 1);

      final courseRef = firestoreData.docs.first;
      expect(courseRef.data()['id'], courseRef.id);

      final groupData = await firestore.collection('groups').get();
      expect(groupData.docs.length, 1);

      final groupRef = groupData.docs.first;
      expect(groupRef.data()['id'], groupRef.id);

      expect(courseRef.data()['groupId'], groupRef.id);
      expect(groupRef.data()['coursed'], courseRef.id);
    });
  });
}
