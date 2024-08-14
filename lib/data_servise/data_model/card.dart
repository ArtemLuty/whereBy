import 'package:json_annotation/json_annotation.dart';
import 'content.dart';

part 'card.g.dart';

@JsonSerializable()
class UserCard {
  final String id;
  final String level;
  final String name;
  final String type;
  final Content content;

  UserCard({
    required this.id,
    required this.level,
    required this.name,
    required this.type,
    required this.content,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) =>
      _$UserCardFromJson(json);
  Map<String, dynamic> toJson() => _$UserCardToJson(this);
}
