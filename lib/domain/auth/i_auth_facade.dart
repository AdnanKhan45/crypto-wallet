




import 'package:crypto_wallet_application/domain/auth/user_entity.dart';
import 'package:crypto_wallet_application/domain/auth/value_objects.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_failure.dart';

abstract class IAuthFacade {
  Future<Option<UserEntity>> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signOut();
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
