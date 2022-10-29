import 'package:http/http.dart' as http;

mixin NetworkX {}

const headerIfModifiedSince = "If-Modified-Since";
const headerLastModified = "Last-Modified";
const headerContentType = "Content-Type";
const headerAuthorization = "Authorization";

extension ResponseX on http.Response {
  bool get isSuccessful => statusCode >= 200 && statusCode <= 299;

  bool get isServerError => statusCode >= 500 && statusCode <= 599;
}
