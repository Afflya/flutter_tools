mixin ScopeFunctionsX {}

extension ScopeFunctions<T> on T {
  void run(Function(T it) block) {
    block.call(this);
  }

  T also(T Function(T it) block) {
    return block.call(this);
  }

  T apply(void Function(T it) block) {
    block.call(this);
    return this;
  }

  Future<T> alsoAsync(Future<T> Function(T it) block) async {
    return block.call(this);
  }

  R let<R>(R Function(T it) block) {
    return block.call(this);
  }

  R? letNullable<R>(R? Function(T it) block) {
    return block.call(this);
  }

  Future<R> letAsync<R>(Future<R> Function(T it) block) async {
    return block.call(this);
  }

  Future<R?> letNullableAsync<R>(Future<R?> Function(T it) block) async {
    return block.call(this);
  }
}

extension ScopeFunctionsNullable<T> on T? {
  T valueOrDefault(T defaultValue) => this ?? defaultValue;

  R? letOnNull<R>(R? Function() block) => letOrElse(onNull: () => block.call());

  R? letOrElse<R>({
    R? Function(T it)? onValue,
    R? Function()? onNull,
  }) {
    // ignore: null_check_on_nullable_type_parameter
    return this == null ? onNull?.call() : onValue?.call(this!);
  }

  Future<R?> letOrElseAsync<R>({
    Future<R?> Function(T it)? onValue,
    Future<R?> Function()? onNull,
  }) async {
    // ignore: null_check_on_nullable_type_parameter
    return this == null ? onNull?.call() : onValue?.call(this!);
  }
}

T? run<T>(T? Function<T>() block) => block.call();

R? runWith<T, R>(T? it, R? Function(T? it) block) => block.call(it);

