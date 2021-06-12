import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/route_generator.dart';
import 'package:trapo_care/screens/splashScreen/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(TrapoCare());
  });
}

class TrapoCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
            statusBarColor: blueColor,
            /* set Status bar color in Android devices. */
            statusBarIconBrightness: Brightness.light,
            /* set Status bar icons color in Android devices.*/
            systemNavigationBarColor: Colors.transparent,
            /* set Status bar icons color in Android devices.*/
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarBrightness:
                Brightness.dark) /* set Status bar icon color in iOS. */
        );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: kPrimaryColor,
      // ),
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
        //textTheme: AppTheme.textTheme,

        fontFamily: GoogleFonts.barlow().fontFamily,
      ),
      home: SplashScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF171D2F,
  const <int, Color>{
    50: const Color(0xFF171D2F),
    100: const Color(0xFF171D2F),
    200: const Color(0xFF171D2F),
    300: const Color(0xFF171D2F),
    400: const Color(0xFF171D2F),
    500: const Color(0xFF171D2F),
    600: const Color(0xFF171D2F),
    700: const Color(0xFF171D2F),
    800: const Color(0xFF171D2F),
    900: const Color(0xFF171D2F),
  },
);
