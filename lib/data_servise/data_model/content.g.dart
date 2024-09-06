// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      text: json['text'] as String?,
      image1: json['image_1'] as String?,
      image2: json['image_2'] as String?,
      voiceover: json['voiceover'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      phrase: json['phrase'] as String?,
      example: json['example'] as String?,
      question: json['question'] as String?,
      explanation: json['explanation'] as String?,
      task: json['task'] as String?,
      idiom: json['idiom'] as String?,
      theme: json['theme'] as String?,
      sentences: (json['sentences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      words:
          (json['words'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'text': instance.text,
      'image_1': instance.image1,
      'image_2': instance.image2,
      'voiceover': instance.voiceover,
      'description': instance.description,
      'image': instance.image,
      'phrase': instance.phrase,
      'example': instance.example,
      'question': instance.question,
      'explanation': instance.explanation,
      'task': instance.task,
      'idiom': instance.idiom,
      'theme': instance.theme,
      'sentences': instance.sentences,
      'words': instance.words,
    };
