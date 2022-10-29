import 'dart:convert';

mixin JsonX {}

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

extension JsonStringExt on String {
  JsonObject get toJsonObject => json.decode(this) as JsonObject;

  JsonArray get toJsonArray => json.decode(this) as JsonArray;
}
