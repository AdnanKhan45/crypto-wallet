
import 'package:crypto_wallet_application/domain/core/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required UniqueId id,
  }) = _UserEntity;
}