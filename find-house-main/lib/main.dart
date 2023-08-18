import 'package:findhouse/notifiers/home_searcher/propertiesNotifier.dart';
import 'package:findhouse/notifiers/property_owner/properties.dart';
import 'package:findhouse/screens/login_screen.dart';
import 'package:findhouse/screens/openingscreen.dart';
import 'package:findhouse/screens/splash_screen.dart';
import 'package:findhouse/screens/splash_screen2.dart';
import 'package:findhouse/widgets/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notifiers/property_owner/category.dart';
import 'notifiers/user_notifier.dart';
import 'package:findhouse/notifiers/app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = FirebaseOptions(
    
    appId: '1:342325251709:android:212a89c53e00fc7dfcab14',
    apiKey: 'AIzaSyC8XEuSZc7L0Ay2pWRYi6Pg773DVm3HZd4',
    messagingSenderId: '342325251709',
    projectId: 'drinkapp-16c27',
   // databaseURL: 'YOUR_DATABASE_URL',
    storageBucket: 'drinkapp-16c27.appspot.com',
  );
  await Firebase.initializeApp( options: firebaseOptions);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppNotifier()),
        ChangeNotifierProvider.value(value: UserNotifier.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: PropertiesProvider.initialize()),
        ChangeNotifierProvider(
          create: (context) => PropertyNotifier(),
        ),
      ],
      child: ThemeBuilder(
          defaultBrightness: Brightness.light,
          builder: (context, brightness) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Find House',
                theme: ThemeData(
                    primarySwatch: Colors.blue, brightness: brightness),
                home: const ScreensController());
          })));
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserNotifier>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return const SplashScreen();
      case Status.Unauthenticated:
        return const SplashScreen();
      case Status.Authenticating:
        return const LoginScreen();
      case Status.Authenticated:
        return const OpeningView();
      default:
        return const SplashHome();
    }
  }
}
