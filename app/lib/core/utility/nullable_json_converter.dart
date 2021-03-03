/// A utility to return a nullable type from JSON
class NullableJsonConverter<T> {
  T? getFromJsonMaybe(
      {required dynamic json, required T Function(dynamic) transform}) {
    if (json == null) return null;
    return transform(json);
  }
}
