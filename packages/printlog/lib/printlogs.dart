import 'dart:developer' as dev;

class PrintLog {
  PrintLog(text) {
    green(text);
  }
  static void green(dynamic data) {
    String text = data.toString();
    dev.log('\x1B[32m$text\x1B[0m');
  }

  static void yellow(dynamic data) {
    String text = data.toString();
    dev.log('\x1B[33m$text\x1B[0m');
  }

  static void red(dynamic data) {
    String text = data.toString();
    dev.log('\x1B[31m$text\x1B[0m');
  }

  static void blue(dynamic data) {
    String text = data.toString();
    dev.log('\x1B[34m$text\x1B[0m');
  }
}
