import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_pe/constant/app_theme.dart';
import 'package:food_pe/constant/strings.dart';
import 'package:food_pe/navigation/bottom_navigation.dart';
import 'package:food_pe/provider/product_provider.dart';
import 'package:food_pe/provider/user_provider.dart';
import 'package:food_pe/service/authentication_service.dart';
import 'package:food_pe/utils/routes.dart';
import 'package:food_pe/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        ListenableProvider<ProductProvider>(create: (_) => ProductProvider()),
        ListenableProvider<UserProvider>(create: (_) => UserProvider()),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightThemeData,
        title: Strings.appName,
        routes: Routes.routes,
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return BottomNavigation();
    }
    return WelcomeScreen();
  }
}
