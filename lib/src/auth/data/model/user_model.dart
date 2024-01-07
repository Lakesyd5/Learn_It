import 'package:learn_it/core/utils/typeDefs.dart';
import 'package:learn_it/src/auth/domain/entities/user_entity.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds = const [],
    super.enrolledCourseIds = const [],
    super.following = const [],
    super.followers = const [],
    super.profilePic,
    super.bio,
  });

  const LocalUserModel.empty()
      : this(
          uid: '',
          email: '',
          points: 0,
          fullName: '',
        );

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          email: map['email'] as String,
          points: (map['points'] as num).toInt(),
          fullName: map['fullName'] as String,
          profilePic: map['profilePic'] as String?,
          bio: map['bio'] as String?,
          groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
          enrolledCourseIds:
              (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
          followers: (map['followers'] as List<dynamic>).cast<String>(),
          following: (map['following'] as List<dynamic>).cast<String>(),
        );

  LocalUser copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    String? fullName,
    int? points,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? followers,
    List<String>? following,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'points': points,
      'fullName': fullName,
      'profilePic': profilePic,
      'bio': bio,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'followers': followers,
      'following': following,
    };
  }
}
