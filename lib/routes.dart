/* 
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:virtual_classroom_meet/layout/login.dart';
import 'package:virtual_classroom_meet/layout/splash.dart';

class Routes extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MultiProvider(
     
     'login': (context) => Login()
    );
  }
}

class MyApp extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: Authentication(),
        )
      ],
      child: MaterialApp(
      title: 'Police',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primarySwatch: Colors.teal,
      ),
      //initialRoute: 'adminlogin',
      routes: {
        'SignIn':(context)=>SignInScreen(),
         'SignUp':(context)=>SignUpScreen(),
         'Home':(context)=>HomeScreen(username: user.email),
         'Map':(context)=>Maps(username: user.email),
         'Save':(context)=>Savelocation(),
         'list':(context)=>ListV(username: user.email),
         'land':(context)=>Landing(),
         'adminlogin':(context)=>AdminLogin(),
         'admin':(context)=>Admin(),
         'CrimeFeed':(context)=>CrimeFeed(username: user.email),
      },
      home: (user == null) ? Landing() : HomeScreen(username: user.email),
   ));
  }
} */