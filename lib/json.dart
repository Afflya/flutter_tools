import 'dart:convert';

import 'package:flutter_tools/cast.dart';
import 'package:flutter_tools/collections.dart';

mixin JsonX {}

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension JsonStringExt on String {
  JsonObject get toJsonObject => json.decode(this) as JsonObject;

  JsonArray get toJsonArray => json.decode(this) as JsonArray;
}

extension JsonObjectExt on JsonObject {
  Object getObj(String key) => this[key] as Object;

  Object? getObjOrNull(String key) => (this[key] as Object?);

  T getAsType<T>(String key) => getObj(key).cast();

  T? getAsTypeOrNull<T>(String key) => getObjOrNull(key)?.castOrNull();

  JsonObject getJsonObj(String key) => this[key] as JsonObject;

  JsonObject? getJsonObjOrNull(String key) => this[key] as JsonObject?;

  Map<String, T> getStringMapOfType<T>(String key) {
    return getJsonObj(key).mapValues((k, v) => v.cast<T>());
  }

  Map<String, T> getStringMapWhereType<T>(String key) {
    return getJsonObj(key).mapValuesNotNull((k, v) => (v as Object?).castOrNull<T>());
  }

  Map<String, T>? getStringMapOfTypeOrNull<T>(String key) {
    return getJsonObjOrNull(key)?.mapValues((k, v) => v.cast<T>());
  }

  Map<String, T>? getStringMapWhereTypeOrNull<T>(String key) {
    return getJsonObj(key).mapValuesNotNull((k, v) => (v as Object?).castOrNull<T>());
  }

  List<T> getListOfType<T>(String key) {
    return (this[key] as JsonArray).castList();
  }

  List<T> getListWhereType<T>(String key) {
    return (this[key] as JsonArray).whereType<T>().toList();
  }

  List<T>? getListOfTypeOrNull<T>(String key) {
    return (this[key] as JsonArray?)?.castListOrNull();
  }

  List<T>? getListWhereTypeOrNull<T>(String key) {
    return (this[key] as JsonArray?)?.whereType<T>().toList();
  }

  List<JsonObject> getListOfJson(String key) {
    return getListOfType(key);
  }

  List<JsonObject>? getListOfJsonOrNull(String key) {
    return getListOfTypeOrNull(key);
  }
}
