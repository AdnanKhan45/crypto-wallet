import 'package:crypto_wallet_application/domain/core/value_objects.dart';
import 'package:crypto_wallet_application/domain/auth/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';


extension FirebaseUserDomainX on User {
  UserEntity toDomain() {
    return UserEntity(id: UniqueId.fromUniqueString(uid));
  }
}