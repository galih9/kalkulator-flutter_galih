import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:function_tree/function_tree.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator/utils/logger.dart';

import '../../blocs/bloc/home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeBloc bloc;
  String dataToCount = "0";
  String result = "0";
  final List<String> _list = [
    "(",
    ")",
    "%",
    "C",
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
    bloc = context.read<HomeBloc>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Demo Home Page'),
      // ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (BuildContext context, Object? state) {
          setState(() {
            print(state.toString());
            if (state is HomeLoadedState) {
              result = state.result;
              dataToCount = state.newDataCount;
            }
          });
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.amber,
                    child: Text(
                      "result",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.amberAccent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      result,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "value",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (state is HomeLoadingState)
                    const Text("loading...")
                  else
                    Container(
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        dataToCount,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Center(
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    children: [
                      for (var i in _list)
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              ((isNumericUsingRegularExpression(i))
                                  ? Colors.blueGrey
                                  : (i == "=")
                                      ? Colors.blue
                                      : Colors.grey),
                            ),
                          ),
                          onPressed: () {
                            CustomLogger.verboose(i);
                            setState(() {
                              if (dataToCount == "0") {
                                if (isNumericUsingRegularExpression(i)) {
                                  bloc.add(
                                    HomeInsertNumberEvent(
                                      dataToCount,
                                      i,
                                      result,
                                    ),
                                  );
                                } else {
                                  CustomLogger.info(
                                      "non angka di awal itu invalid");
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: const Text(
                                        'dont put operators as the first character!'),
                                    action: SnackBarAction(
                                      label: 'Okay',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              } else if (i == "C") {
                                // dataToCount = removeLastCharacter(dataToCount);
                                bloc.add(
                                  HomeDeleteNumberEvent(
                                    dataToCount,
                                    result,
                                  ),
                                );
                              } else if (i == "=") {
                                CustomLogger.info("get result $result");
                                // String temp =
                                //     dataToCount.interpret().toStringAsFixed(2);
                                // result = (checkIfLastCharacterIsRoundable(temp))
                                //     ? temp.substring(0, temp.length - 3)
                                //     : temp;
                                bloc.add(
                                  HomeCalculateEvent(dataToCount, result),
                                );
                              } else {
                                // dataToCount += i;
                                print("trigger insert number");
                                bloc.add(
                                  HomeInsertNumberEvent(dataToCount, i, result),
                                );
                              }
                            });
                          },
                          child: Text(
                            i,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

                            // final snackBar = SnackBar(
                            //   duration: Duration(seconds: 1),
                            //   content: const Text('Yay! A SnackBar!'),
                            //   action: SnackBarAction(
                            //     label: 'Okay',
                            //     onPressed: () {
                            //       // Some code to undo the change.
                            //     },
                            //   ),
                            // );

                            // ScaffoldMessenger.of(context)
                            //     .showSnackBar(snackBar);

// (i == "=") {
//                               print("result");
//                             } else if (i == "C") {
//                               print("clear");
//                             } else if (i == ".") {
//                               print("dot");
//                             } else if (i == "-") {
//                               print("minus");
//                             } else if (i == "+") {
//                               print("plus");
//                             } else if (i == "*") {
//                               print("kali");
//                             } else if (i == "/") {
//                               print("divide");
//                             } else if (i == "%") {
//                               print("percentage");
//                             } else if (i == "(") {
//                               print("buka kurung");
//                             } else if (i == ")") {
//                               print("tutup kurung");
//                             } else {
//                               print("$i");
//                               if (dataToCount == "0") {
//                                 dataToCount = i;
//                               } else {
//                                 dataToCount += i;
//                               }