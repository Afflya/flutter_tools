extension CastExt on dynamic {
  T? asOrNull<T>() => this is T ? this : null;

  T as<T>() => this as T;
}

T? tryCast<T>(x) => x is T ? x : null;
