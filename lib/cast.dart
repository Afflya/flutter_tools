extension CastExt on Object? {
  T cast<T>() => this as T;

  T? castOrNull<T>() => this is T ? cast<T>() : null;
}

extension ListCastExt on List<dynamic> {

  List<T> castList<T>() {
    return List<T>.from(this);
  }

  List<T>? castListOrNull<T>() {
    try {
      // For non-nullable T, reject any null values
      if (null is! T && contains(null)) {
        return null;
      }

      // Check if all elements are of type T
      for (final element in this) {
        if (element is! T && element != null) {
          return null;
        }
      }
      // If all checks passed, cast the list
      return List<T>.from(this);
    } catch (e) {
      return null;
    }
  }

}

T? castOrNull<T>(x) => x is T ? x : null;
