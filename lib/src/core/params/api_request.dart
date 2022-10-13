// ignore_for_file: public_member_api_docs, sort_constructors_first
enum HTTPMethod { get, post, delete, put, patch }

extension HTTPMethodString on HTTPMethod {
  String get string {
    switch (this) {
      case HTTPMethod.get:
        return "get";
      case HTTPMethod.post:
        return "post";
      case HTTPMethod.delete:
        return "delete";
      case HTTPMethod.patch:
        return "patch";
      case HTTPMethod.put:
        return "put";
    }
  }
}

class APIRequestParams {
  final String url;
  final HTTPMethod method;
  final Map<String, String>? headers;
  final Map<String, dynamic>? query;
  final dynamic body;

  const APIRequestParams({
    required this.url,
    required this.method,
    this.headers = const {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    },
    this.query,
    this.body,
  }) /*: assert(method == HTTPMethod.post && body != null) */;
}
