import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
  ),
);

class CustomLogger {
  static void warning(any) {
    logger.w(any);
  }

  static void error(any) {
    logger.e(any);
  }

  static void info(any) {
    logger.i(any);
  }

  static void verboose(any) {
    logger.v(any);
  }

  static void printWrapped(String text) =>
      // ignore: avoid_print
      RegExp('.{1,800}').allMatches(text).map((m) => m.group(0)).forEach(print);
}
