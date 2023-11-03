extension EnumExtensionsX<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    if (name == null) return null;

    for (final value in this) {
      if (value.name == name) return value;
    }

    return null;
  }
}
