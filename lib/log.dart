import 'package:logger/logger.dart';

class Log {

  static final Logger _logger = Logger(
    printer: _LogPrinter(),
  );

  Log._();

  static void d(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.d('$tag: $message', error, stackTrace);
  }

  static void v(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.v('$tag: $message', error, stackTrace);
  }

  static void e(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.e('$tag: $message', error, stackTrace);
  }

  static void i(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.i('$tag: $message', error, stackTrace);
  }

  static void w(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.w('$tag: $message', error, stackTrace);
  }

  static void wtf(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.wtf('$tag: $message', error, stackTrace);
  }

}

class _LogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message.toString()];
  }

}
