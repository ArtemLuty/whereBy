// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCard _$UserCardFromJson(Map<String, dynamic> json) => UserCard(
      id: json['id'] as String,
      level: json['level'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      content: Content.fromJson(json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCardToJson(UserCard instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'type': instance.type,
      'content': instance.content,
    };
