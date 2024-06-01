// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskResponse _$AddTaskResponseFromJson(Map<String, dynamic> json) =>
    AddTaskResponse(
      image: json['image'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      user: json['user'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AddTaskResponseToJson(AddTaskResponse instance) =>
    <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'desc': instance.desc,
      'priority': instance.priority,
      'status': instance.status,
      'user': instance.user,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
