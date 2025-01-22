import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tictac/src/common/route/app_route.dart';
import 'package:tictac/src/pages/HomePage/views/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    Size screensize = MediaQuery.of(context).size;
    return ScreenUtilInit(
        designSize: screensize,
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  primary: Colors.blue,
                  secondary: Colors.blueAccent,
                ),
                useMaterial3: true),
            //AppRoutes is a custom class that holds all the routes in the app
            routerConfig: router,
          );
        },
        child: HomeScreen());
  }
}
