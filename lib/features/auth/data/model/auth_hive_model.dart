import 'package:flaviourfleet/app/constants/hive_table_constant.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider((ref) => AuthHiveModel.empty());

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fullName;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.fullName,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  AuthHiveModel.empty()
      : userId = '',
        fullName = '',
        email = '',
        password = '';

  // convert hive object entity
  AuthEntity toEntity() => AuthEntity(
      userId: userId, fullName: fullName, email: email, password: password);

  // convert entity to hive objct
  AuthHiveModel toHiveModel(AuthEntity entity) => AuthHiveModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password);

  //convert hive list to entity
  List<AuthHiveModel> toHiveModelList(List<AuthEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullName: $fullName, email: $email, password: $password';
  }
}
