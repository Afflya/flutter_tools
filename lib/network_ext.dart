import 'package:http/http.dart' as http;

mixin NetworkX {}

const headerIfModifiedSince = "If-Modified-Since";
const headerLastModified = "Last-Modified";
const headerContentType = "Content-Type";
const headerAuthorization = "Authorization";

mixin DomainConfig {
  static String defaultScheme = 'https';

  String? get scheme;

  String? get domain;

  String get urlScheme => scheme ?? defaultScheme;

  String? get urlDomain => domain == null ? null : '$urlScheme://$domain';
}

extension ResponseX on http.Response {
  bool get isSuccessful => statusCode >= 200 && statusCode <= 299;

  bool get isServerError => statusCode >= 500 && statusCode <= 599;
}
