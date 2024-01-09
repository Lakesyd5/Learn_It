import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learn_it/core/enums/update_user.dart';
import 'package:learn_it/core/errors/exception.dart';
import 'package:learn_it/src/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _authClient = authClient,
        _cloudStoreClient = cloudStoreClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authClient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? 'Unknown error', statusCode: e.code);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      _authClient.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      
    }
  }

  @override
  Future<void> signUp(
      {required String email,
      required String password,
      required String fullName}) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser({required UpdateUserAction action, userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
