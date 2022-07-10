import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:desktop_window/desktop_window.dart' as window_size;
// import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'blocs/home_bloc.dart';
import 'screens/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (context) => HomeBloc(),
      child: const MyApp(),
    ),
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.DesktopWindow.setWindowSize(const Size(400, 800));
    window_size.DesktopWindow.setMinWindowSize(const Size(375, 750));
    window_size.DesktopWindow.setMaxWindowSize(const Size(600, 1500));
    // doWhenWindowReady(() {
    //   const initialSize = Size(600, 450);
    //   appWindow.minSize = initialSize;
    //   appWindow.size = initialSize;
    //   appWindow.alignment = Alignment.center;
    //   appWindow.show();
    // });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}
