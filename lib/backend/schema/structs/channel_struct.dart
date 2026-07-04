// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChannelStruct extends BaseStruct {
  ChannelStruct({
    String? name,
    String? description,
    String? image,
    String? followers,
  })  : _name = name,
        _description = description,
        _image = image,
        _followers = followers;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "followers" field.
  String? _followers;
  String get followers => _followers ?? '';
  set followers(String? val) => _followers = val;

  bool hasFollowers() => _followers != null;

  static ChannelStruct fromMap(Map<String, dynamic> data) => ChannelStruct(
        name: data['name'] as String?,
        description: data['description'] as String?,
        image: data['image'] as String?,
        followers: data['followers'] as String?,
      );

  static ChannelStruct? maybeFromMap(dynamic data) =>
      data is Map ? ChannelStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'description': _description,
        'image': _image,
        'followers': _followers,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'followers': serializeParam(
          _followers,
          ParamType.String,
        ),
      }.withoutNulls;

  static ChannelStruct fromSerializableMap(Map<String, dynamic> data) =>
      ChannelStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        followers: deserializeParam(
          data['followers'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ChannelStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ChannelStruct &&
        name == other.name &&
        description == other.description &&
        image == other.image &&
        followers == other.followers;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, description, image, followers]);
}

ChannelStruct createChannelStruct({
  String? name,
  String? description,
  String? image,
  String? followers,
}) =>
    ChannelStruct(
      name: name,
      description: description,
      image: image,
      followers: followers,
    );
