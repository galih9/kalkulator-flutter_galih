import 'package:flutter/material.dart';
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

class CalcUtils {
  static List<String> getButtonLabels() {
    return [
      "(",
      ")",
      "CE",
      "Del",
      "7",
      "8",
      "9",
      "/",
      "4",
      "5",
      "6",
      "*",
      "1",
      "2",
      "3",
      "-",
      "0",
      ".",
      "=",
      "+",
    ];
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    if (string == ".") {
      return false;
    }
    if (string == "-") {
      return false;
    }

    return numericRegex.hasMatch(string);
  }

  static String removeLastCharacter(String string) {
    if (string.length == 1) {
      return "0";
    }
    return string.substring(0, string.length - 1);
  }

  static bool checkIfLastCharacterIsRoundable(String string) {
    if (string.length == 1) {
      return false;
    }
    if (string.substring(string.length - 2, string.length) == "00") {
      return true;
    }
    return false;
  }

  static bool checkIfLastCharacterIsOperator(String string) {
    if (string.length == 1) {
      return false;
    }
    if (string.substring(string.length - 1, string.length) == ".") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "-") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "+") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "/") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "*") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "^") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == ")") {
      return true;
    }
    if (string.substring(string.length - 1, string.length) == "(") {
      return true;
    }
    return false;
  }

  static void showSnackbar(context, String message) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        message,
      ),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
