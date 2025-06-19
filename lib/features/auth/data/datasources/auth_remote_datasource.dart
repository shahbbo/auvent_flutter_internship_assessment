import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signup(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  firebase_auth.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
        );
      } else {
        throw ServerException(
          'Failed to log in. Please try again later.',
        );
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('The email address is not valid.');
      } else if (e.code == 'user-disabled') {
        throw AuthException('This user has been disabled.');
      } else if (e.code == 'invalid-credential') {
        throw AuthException('mail or password is incorrect.');
      } else {
        throw ServerException(
          'An error occurred while logging in. Please try again later.',
        );
      }
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred while logging in. Please try again later.',
      );
    }
  }

  @override
  Future<UserModel> signup(String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        return UserModel(
          id: userCredential.user!.uid,
          email: userCredential.user!.email ?? '',
        );
      } else {
        throw ServerException(
          'Failed to create user. Please try again later.',
        );
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      print('FirebaseAuthException in datasource: ${e.code}');
      if (e.code == 'weak-password') {
        throw AuthException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw AuthException('The email address is not valid.');
      } else if (e.code == 'invalid-credential') {
        throw AuthException('mail or password is not valid.');
      } else {
        throw ServerException(
          'An error occurred while signing up. Please try again later.',
        );
      }
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred while signing up. Please try again later.',
      );
    }
  }
}
