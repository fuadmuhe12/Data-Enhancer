
class Logger {
  void debug(String message) {
    _log('DEBUG', message);
  }

  void info(String message) {
    _log('INFO', message);
  }

  void warning(String message) {
    _log('WARNING', message);
  }

  void error(String message) {
    _log('ERROR', message);
  }

  void _log(String level, String message) {
    String timestamp = DateTime.now().toIso8601String();
    // ignore: avoid_print
    print('$timestamp [$level]: $message');
  }
}

Logger  customLogger = Logger();