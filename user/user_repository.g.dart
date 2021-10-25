// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EBUser _$EBUserFromJson(Map<String, dynamic> json) => EBUser(
      json['id'] as String,
      json['email'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$EBUserToJson(EBUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      json['id'] as String,
      json['userId'] as String,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
    };
