import 'dart:convert';

import 'package:flutter_tools/cast.dart';

mixin JsonX {}

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension JsonStringExt on String {
  JsonObject get toJsonObject => json.decode(this) as JsonObject;

  JsonArray get toJsonArray => json.decode(this) as JsonArray;
}

extension JsonObjectExt on JsonObject {
  Object? getObj(String key) => (this[key] as Object?);

  T? getAsType<T>(String key) => getObj(key)?.castOrNull();

  JsonObject? getJsonObj(String key) => this[key] as JsonObject?;

  List<T>? getListOfType<T>(String key) {
    return (this[key] as JsonArray?)?.castList();
  }

  List<T>? getListOfTypeOrNull<T>(String key) {
    return (this[key] as JsonArray?)?.castListOrNull();
  }

  List<JsonObject>? getListOfJson(String key) {
    return (this[key] as JsonArray?)?.castList();
  }

  List<JsonObject>? getListOfJsonOrNull(String key) {
    return (this[key] as JsonArray?)?.castListOrNull();
  }
}
