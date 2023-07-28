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
    _logger.d('$tag: $message', error: error, stackTrace: stackTrace);
  }

  static void v(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.t('$tag: $message', error: error, stackTrace: stackTrace);
  }

  static void e(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.e('$tag: $message', error: error, stackTrace: stackTrace);
  }

  static void i(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.i('$tag: $message', error: error, stackTrace: stackTrace);
  }

  static void w(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.w('$tag: $message', error: error, stackTrace: stackTrace);
  }

  static void wtf(final dynamic tag,
      final dynamic message,
      [
    final dynamic error,
    final StackTrace? stackTrace,
  ]) {
    assert(tag != null);
    _logger.f('$tag: $message', error: error, stackTrace: stackTrace);
  }

}

class _LogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    return [event.message.toString()];
  }

}
