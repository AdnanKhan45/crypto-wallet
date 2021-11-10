import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet_application/domain/auth/auth_failure.dart';
import 'package:crypto_wallet_application/domain/auth/i_auth_facade.dart';
import 'package:crypto_wallet_application/domain/auth/user_entity.dart';
import 'package:crypto_wallet_application/domain/auth/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:crypto_wallet_application/infrastructure/auth/firebase_user_mapper.dart';

@Injectable(as: IAuthFacade)
class IAuthFacadeImpl implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  IAuthFacadeImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Option<UserEntity>> getSignedInUser() async => optionOf(_firebaseAuth.currentUser?.toDomain());

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required EmailAddress emailAddress, required Password password}) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: emailAddressStr, password: passwordStr);
      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == "error_email_already_in_use") {
        return left(AuthFailure.emailAlreadyInUse());
      } else {
        return left(AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'error_wrong_password' ||
          e.code == 'error_user_not_found') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      await _firebaseAuth.signInWithCredential(authCredential);
      return right(unit);
    } on FirebaseAuthException catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<void> signOut() =>
      Future.wait([
        _googleSignIn.signOut(),
        _firebaseAuth.signOut(),
      ]);
}