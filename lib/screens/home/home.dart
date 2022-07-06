import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator/screens/widgets/home_widgets.dart';
import 'package:kalkulator/utils/logger.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataToCount = "0";
  String result = "0";
  final List<String> _list = [
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

  @override
  void initState() {
    super.initState();
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    if (string == ".") {
      return false;
    }
    if (string == "-") {
      return false;
    }

    return numericRegex.hasMatch(string);
  }

  String removeLastCharacter(String string) {
    if (string.length == 1) {
      return "0";
    }
    return string.substring(0, string.length - 1);
  }

  bool checkIfLastCharacterIsRoundable(String string) {
    if (string.length == 1) {
      return false;
    }
    if (string.substring(string.length - 2, string.length) == "00") {
      return true;
    }
    return false;
  }

  bool checkIfLastCharacterIsOperator(String string) {
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

  void showSnackbar(context, String message) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Demo Home Page'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderDisplayer(
            value: result,
            color: Colors.amberAccent,
            colorLabel: Colors.amber,
            label: "result",
          ),
          HeaderDisplayer(
            value: dataToCount,
            color: Colors.greenAccent,
            colorLabel: Colors.green,
            label: "value",
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Center(
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                children: [
                  for (var i in _list)
                    CalculatorButtons(
                      btnStyle: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ((isNumericUsingRegularExpression(i))
                              ? Colors.blueGrey
                              : (i == "=")
                                  ? Colors.blue
                                  : Colors.grey),
                        ),
                      ),
                      label: i,
                      onPressed: () {
                        CustomLogger.verboose(i);
                        setState(
                          () {
                            if (dataToCount == "0") {
                              if (isNumericUsingRegularExpression(i)) {
                                dataToCount = i;
                              } else {
                                CustomLogger.warning(
                                  "angka di harus awal, gak boleh operator",
                                );
                                showSnackbar(
                                  context,
                                  "dont put operators as the first character!",
                                );
                              }
                            } else if (i == "Del") {
                              dataToCount = removeLastCharacter(dataToCount);
                            } else if (i == "CE") {
                              dataToCount = "0";
                            } else if (i == "=") {
                              if (checkIfLastCharacterIsOperator(dataToCount)) {
                                CustomLogger.warning(
                                  "operator di akhir itu invalid",
                                );
                                showSnackbar(
                                  context,
                                  "dont put operators as the last character!",
                                );
                              } else {
                                String temp =
                                    dataToCount.interpret().toStringAsFixed(2);
                                result = (checkIfLastCharacterIsRoundable(temp))
                                    ? temp.substring(0, temp.length - 3)
                                    : temp;
                                CustomLogger.info("get result $result");
                              }
                            } else {
                              dataToCount += i;
                            }
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
